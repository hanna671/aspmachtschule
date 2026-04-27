
# coding: utf-8
import argparse
import gc
import clingo
from clingo.control import Control
from clingo.backend import Observer
import matplotlib
#matplotlib.use('Agg') 
import matplotlib.pyplot as plt
import pandas as pd
import networkx as nx
from datetime import datetime
import threading
import sys
import plotly.express as px
import seaborn as sns
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
    {'name':'allocation', 'filter':lambda s: s.name=='allocation', 'columns':['name','room']},
    {'name':'sameRoomSameProject', 'filter':lambda s: s.name=='sameRoomSameProject', 'columns':['name1','name2']},
    {'name':'teacher', 'filter':lambda s: s.name=='teacher', 'columns':['name','subject']}
]

def cprint(Text):
    global print_details
    if print_details:
        print(Text)

def compute_costs(modelIndex, all_data_frames):
    global outputfolder

    current_allocation_df = all_data_frames["currentRoom"]
    current_allocation_df_dict_org = dict(zip(current_allocation_df['name'].values, current_allocation_df['room'].values))
    current_allocation_dict = {k.name:current_allocation_df_dict_org.get(k).name for k in current_allocation_df_dict_org}

    new_allocation_df = all_data_frames["allocation"]
    new_allocation_df_dict_org = dict(zip(new_allocation_df['name'].values, new_allocation_df['room'].values))
    new_allocation_dict = {k.name:new_allocation_df_dict_org.get(k).name for k in new_allocation_df_dict_org}

    sameRoomSameProject_df = all_data_frames["sameRoomSameProject"]
    sameRoomSameProject_dict_org = dict(zip(sameRoomSameProject_df['name1'].values, sameRoomSameProject_df['name2']))
    sameRoomSameProject_dict = {k.name:sameRoomSameProject_dict_org.get(k).name for k in sameRoomSameProject_dict_org}


    movePerson_df = all_data_frames["movePerson"]
    movePerson_list = list(movePerson_df['name'].values)
    sameRoomSameProject_dict = {k.name:sameRoomSameProject_dict_org.get(k).name for k in sameRoomSameProject_dict_org}

    nr_of_no_realloc = len(movePerson_list) #sum(1 for key in current_allocation_dict if current_allocation_dict[key] == new_allocation_dict[key])
    same_room_same_project = len(sameRoomSameProject_dict)

    print("calculating cost ...")
    #print(movePerson_list)
    #print(nr_of_no_realloc)
    thisCost = {"model_id": modelIndex,"same_room_same_project":same_room_same_project, "nr_of_realloc":nr_of_no_realloc}
    costs.append(thisCost)
    cost_df = pd.DataFrame(data=costs, columns=['model_id','same_room_same_project', 'nr_of_realloc'])
    cost_df.set_index("model_id", inplace=True)
    cost_df.to_csv(f"{outputfolder}/costs.csv")

    
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

def solve_clingo(programs, max_models=1):
    global start_time_solving, produced_at_atoms, ctl
    print('Configuring Clingo ...')
    print(f'--models={max_models}')

    ctl = clingo.Control(
        ['--warn=no-atom-undefined', f'--models={max_models}', "--opt-mode=optN", "--parallel-mode=12"])
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

    res = ctl.solve(on_model=on_model)
    ctl.cleanup()
    return res


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
        for modelAtomTemplate in modelAtomTemplates:
            showModelAtoms(path_symbols, modelAtomTemplate['name'], modelAtomTemplate['filter'], modelAtomTemplate['columns'],
                        foundModelIndex)
    
        #thread = threading.Thread(target=processModel, args=(m, analyzedModelIndex,), daemon=False)
        #thread.start()
        processModel(m, foundModelIndex)

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
    solve_clingo(get_programs_by_categories(categories), max_nr_models)
    #gc.collect()  
if __name__ == "__main__":
    myobs = hf.MyObserver()
    run_asp()