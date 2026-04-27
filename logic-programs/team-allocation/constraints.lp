#const rounds = 3.
#const max_group_size = 6.
#const groups = 5.
#const group_size_variation = 1.

personInfo(Name,Project,Site) :- person(Name), assignedTo(Name,Project), locatedAt(Name,Site).

round_nr(1..rounds).
group_nr(1..groups).

total_nr_of_part(X) :- X=#count{1, N: person(N)}.

% specify rounds number of groups
rounds{group(R,N,Name,Site):round_nr(R),group_nr(N)}rounds :- personInfo(Name,_,Site).

% size range of group
:- group(M,N,_,_), max_group_size<#count{1, Name: group(M,N,Name,_)}.

% i dont remember the usefulness of this constraint
%test :- round_nr(R), group(R,_,Name,_), not person(Name).
%#show test/0.

% each team needs at least 1 person in hamburg
:- not group(R,N,_,hamburg), round_nr(R), group_nr(N). 

% diversify the groups with respect to where the persons are situated
#minimize{Count:site_in_group(_,_,_,Count)}.
site_in_group(R,N,Site,Count) :- group(R,N,_,Site), Count=#count{1,Name:group(R,N,Name,Site)}.

:- group(R,N,Name1,_), group(R,N,Name2,_), chair(Name1), chair(Name2), Name1!=Name2.
:- group(R,N1,Name,_), group(R,N2,Name,_), N1!=N2.


invalid_round_alloc(Name) :- group(R,N1,Name,_), group(R,N2,Name,_), N1!=N2. 
#show invalid_round_alloc/1.