
# coding: utf-8
import argparse
import gc
import clingo
from clingo.control import Control
from clingo.backend import Observer
#matplotlib.use('Agg') 
import pandas as pd
from datetime import datetime
import threading
import sys
import plotly.express as px
import helper_functions as hf

import os
import plotly.graph_objects as go
import time
import shutil
import csv
import json
import pickle
#import compute_similarity
#import create_best_model_dataframe

#import create_best_model_dataframe

#matplotlib.use('TkAgg')
import matplotlib.pyplot as plt

YELLOW = "\033[33m"
RESET = "\033[0m"  

showModel = False
showDataframes = False
print_details = True
foundModelIndex = 0
analyzedModelIndex = 0
all_data_frames = {}
costs = []
modelAtomTemplates = [    
    {'name':'movePerson','filter':lambda s: s.name=='movePerson', 'columns':['name']},
    {'name':'currentRoom','filter':lambda s: s.name=='currentRoom', 'columns':['name','room']},
    {'name':'allocation', 'filter':lambda s: s.name=='allocation', 'columns':['class','room','subject', 'day', 'timeslot','teacher']},
    {'name':'sameRoomSameProject', 'filter':lambda s: s.name=='sameRoomSameProject', 'columns':['name1','name2']},
    {'name':'dist', 'filter':lambda s: s.name=='dist', 'columns':['start','ende','dist']},
    {'name':'total_distance', 'filter':lambda s: s.name== 'total_distance', 'columns':['class', 'dist']},
    {'name':'invalid', 'filter':lambda s: s.name=='invalid', 'columns':['name']},
    {'name':'travel_cost_teacher', 'filter':lambda s: s.name== 'travel_cost_teacher', 'columns':['teacher', 'dist','day', 'timeslot']},
    {'name':'sumblock', 'filter':lambda s: s.name=='sumblock', 'columns':['nr']}

]

def cprint(Text):
    global print_details
    if print_details:
        print(Text)


def extract_clingo_number(val):
    # Case A: It's a Clingo Symbol (has .number attribute)
    if hasattr(val, 'number'):  
        return val.number
    # Case B: It's already a Python int or float
    if isinstance(val, (int, float)):
        return val
    # Case C: It's a string that looks like a number ("6")
    try:
        return float(val)
    except (ValueError, TypeError):
        return 0  # Default fallback if data is bad
        

def compute_costs(modelIndex, all_data_frames):

    global outputfolder

    cprint("calculating cost ...")
    cost = {}

    total_distance_df = all_data_frames["total_distance"]
    total_distance_df['dist'] = total_distance_df['dist'].apply(extract_clingo_number)
    cost["total_distance"] = sum(total_distance_df['dist'])

    travel_cost_teacher_df = all_data_frames["travel_cost_teacher"]
    travel_cost_teacher_df['dist'] = travel_cost_teacher_df['dist'].apply(extract_clingo_number)
    cost["travel_cost_teacher"] = sum(travel_cost_teacher_df['dist'])

    sumblock_df = all_data_frames["sumblock"]
    sumblock_df['nr'] = sumblock_df['nr'].apply(extract_clingo_number)
    cost["sumblock"] = sum(sumblock_df['nr'])

    cost['model_id'] = modelIndex
    
    costs.append(cost)

    cost_df = pd.DataFrame(data=costs, columns=["model_id","total_distance","travel_cost_teacher","sumblock"])
    cost_df.set_index("model_id", inplace=False)
    cost_df.to_csv(f"{outputfolder}/costs.csv")

    return True

    
def get_programs_by_categories(categories: list[str]):
    programs = []
    for category in categories:
        if os.path.isdir(category):
            programs += hf.get_artifacts(category)
        elif os.path.isfile(category):
            programs += [category]
        else:
            print(f"Folder or file \'{category}\' does not exist.")
    return programs

def solve_clingo(programs, max_models=0, timeout=None):
    global start_time_solving, produced_at_atoms, ctl
    print('Configuring Clingo ...')
    print(f'--models={max_models}')

    ctl = clingo.Control(
        ['--warn=no-atom-undefined', f'--models={max_models}', "--parallel-mode=12"])
    print(f'Configuration Keys: {ctl.configuration.solve.keys}')
    ctl.register_observer(myobs)
    myobs.start()#

    for program in programs:
        ctl.load(program)
    start_time_grounding = time.process_time()
    ctl.ground([("base", [])])
    print(
        f"Grounding programs: {programs} ...\n=== Grounding done ({round((time.process_time() - start_time_grounding) / 60, 2)} minutes, {myobs.number_rules} rules, {myobs.number_choice_rules} choice rules) ===")

    start_time_solving = time.process_time()



    if timeout is None:
        res = ctl.solve(on_model=on_model)
    else:
        with ctl.solve(on_model=on_model, async_=True) as handle:
            finished = handle.wait(timeout)
            if not finished:
                print(f"Time limit of {timeout}s reached.")
                handle.cancel()
    ctl.cleanup()
    return True


def processModel(m, modelIndex):
    global check_correctness_var, compute_costs_var
    if check_correctness_var == True:        
        cprint("check correctness ...")
        check_correctness(modelIndex, all_data_frames)
    if compute_costs_var == True:   
        cprint("compute costs ...")
        compute_costs(modelIndex, all_data_frames)
        cprint(f"Done processing Model {modelIndex} ... ")

def showModelAtoms(s, dataName, symbolFilter, columns, index):
    global iD_conversion

    filteredSymbols = list(filter(symbolFilter, s))
    arguments = list(map(lambda s: s.arguments, filteredSymbols))
    df = pd.DataFrame(data=arguments, columns=columns)
    all_data_frames[dataName] = df

    df.to_csv(f"{outputfolder}/model_{index}/{dataName}.csv")
    if showDataframes:
        print(f"========================== {dataName} ==========================")
        print(df.to_string())


def on_model(m: clingo.Model):
    global start_time_solving, output_hundredth_model, foundModelIndex, analyzedModelIndex, outputfolder, exit_after_optimal_found, draw, compute_costs_var

    if not output_hundredth_model or foundModelIndex % 100 == 0:
        cprint(
                f"=== New Model [{foundModelIndex}] found after {str(round((time.process_time() - start_time_solving) / 60, 2))} minutes of solving (Optimality proven: {m.optimality_proven}) === ")
        
        
        hf.emptyFolder(f"./{outputfolder}/model_{foundModelIndex}")

        with open(f"./{outputfolder}/model_{analyzedModelIndex}/model.txt", "w") as model_file:
            model_file.write(str(m))
        
        path_symbols = []
        for name in [next(iter(d.values())) for d in modelAtomTemplates]:
            path_symbols += list(filter(lambda s: s.name == name, m.symbols(atoms=True)))
        cprint(f"Generated {len(path_symbols)} path symbols")

        cprint(f"Start processing Model {foundModelIndex} ... ")
        cprint("creating template atoms ...")
        try:
            for modelAtomTemplate in modelAtomTemplates:
                showModelAtoms(path_symbols, modelAtomTemplate['name'], modelAtomTemplate['filter'], modelAtomTemplate['columns'],
                            foundModelIndex)

            #thread = threading.Thread(target=processModel, args=(m, analyzedModelIndex,), daemon=False)
            #thread.start()
            processModel(m, foundModelIndex)
        except Exception as e:
            print(f"ERROR processing model {foundModelIndex}: {e}")
            import traceback
            traceback.print_exc()
            raise

        if m.optimality_proven:
            print(
                f"=== Optimal model [{foundModelIndex}] found after {str(round((time.process_time() - start_time_solving) / 60, 2))} minutes of solving (Optimality proven: {m.optimality_proven}) === ")

            if exit_after_optimal_found:
                print(str(m))
                if compute_costs_var == True:
                    costs_df = pd.read_csv(f"{outputfolder}/costs.csv")
                    if draw:
                        draw_figures(costs_df)
                sys.exit()

        analyzedModelIndex += 1 

    foundModelIndex += 1

def run_asp(): 
    global output_hundredth_model, outputfolder, start_time_solving, ctl, \
    foundModelIndex, analyzedModelIndex, showModel, print_details, \
    exit_after_optimal_found, draw, check_correctness_var, compute_costs_var
  
    parser = argparse.ArgumentParser(description="Runs logic-programs in sub-folders 'facts' and 'rules'.")
    parser.add_argument("-t", "--timeout", required=False, default=100, type=int, help="time out.")
    parser.add_argument("-d", "--details", required=False, default=False, help="show details on configuration.")
    parser.add_argument("-ch", "--check_correctness", required=False, default=False, help="checks correctness on multi batching.")
    parser.add_argument("-co", "--compute_costs", required=False, default=False, help="compute costs on multi batching.")

    parser.add_argument("-f", "--draw", required=False, default=False, help="draw figures while running.")
    parser.add_argument("-eo", "--exit_after_optimal_found", required=False, default=True, help="Exits after first optimal model is found")
    parser.add_argument("-p", "--print_details", required=False, default=True, help="Prints details to each model found")
    parser.add_argument("-n", "--models", required=False, default=1,
                        help="Maximum number of models returned by the tool.")
    parser.add_argument("-o", "--outputfolder", required=False, default=f'./output-{datetime.now()}', help="The folder to put results into.")
    parser.add_argument("-m", "--showmodel", required=False, action="store_true", default=False,
                        help="Print each model entirely.")
    parser.add_argument("-df", "--showdataframes", required=False, action="store_true", default=False, help="Print each dataframe.")
    parser.add_argument("-e", "--example", required=False, action="store_true", default=False,
                        help="Considers only the logic programs in the example.")
    parser.add_argument("-s", "--output_hundredth_model", required=False, action="store_true", default=False, help="will output each 100th model")
    parser.add_argument("-hr", "--heuristics", required=False, default=False, help="Will run different heuristics combinations from heuristics folder")
    parser.add_argument("-j", "--json_file", required=False,default=0, help="reads json file with all required paramters")
    parser.add_argument("-ts", "--timestamp_on_results_folder", required=False,default=True, help="timestamp_on_results_folder")
    parser.add_argument("-pr", "--program_folder", required=False,default=True, help="folder in which the programs are")
    args = parser.parse_args()

    json_file = args.json_file

    if json_file:

        with open(json_file, 'r') as file_open:
            json_data = json.load(file_open)[0]
        timeout = json_data["timeout"]
        max_nr_models = json_data["max_nr_models"]
        showModel = json_data["show_model"]
        showDataframes = json_data["show_dataframes"]
        example = json_data["example"]
        output_hundredth_model = json_data["output_hundredth_model"]
        heuristics_runs = json_data["runs"]
        all_results_folder = json_data["all_results_folder"]
        print_details = json_data["print_details"]
        exit_after_optimal_found = json_data["exit_after_optimal_found"]
        draw = json_data["draw"]
        check_correctness_var = json_data["check_correctness"]
        compute_costs_var = json_data["compute_costs"]
        program_folder = json_data["program_folder"]

        if json_data["timestamp_on_results_folder"]:
            all_results_folder = f'{all_results_folder}_{datetime.now()}'
    else:
        timeout = args.timeout
        max_nr_models = args.models
        showModel = args.showmodel
        showDataframes = args.showdataframes
        example = args.example
        output_hundredth_model = args.output_hundredth_model
        heuristics_runs = args.heuristics
        json_file = args.json_file
        print_details = args.print_details
        exit_after_optimal_found = args.exit_after_optimal_found
        draw = args.draw
        all_results_folder = F'{args.outputfolder}'
        check_correctness_var = args.check_correctness
        compute_costs_var = args.compute_costs
        program_folder = args.program_folder
        if args.timestamp_on_results_folder:
            all_results_folder = f'{all_results_folder}_{datetime.now()}'

    categories = [f"{program_folder}"]

    hf.emptyFolder(all_results_folder)
    gc.collect()  
    print(f"{YELLOW}============================== {categories} =============================={RESET}") 
    outputfolder = f'{all_results_folder}'
    solve_clingo(get_programs_by_categories(categories), max_nr_models, timeout)
    #gc.collect()  
if __name__ == "__main__":
    myobs = hf.MyObserver()
    run_asp()