% everyone needs to be assigned to exactly one room
1{allocation(Person,Room):room(Room,_)}1 :- staff(Person).
1{allocation(Person,Room):room(Room,_)}1 :- student(Person).

% there cannot be more persons allocated to a room than the number of places (size) of that room
:- room(Room,Size), Size<#count{Person:allocation(Person,Room)}.

% No permanent employee to sit alone in one office (exemption 1 office of 1XRE)
aloneExemption(jasper;helge;vignesh;pedro;johannes).

withSomeoneInOffice(Person1) :- allocation(Person1,R), staff(Person1),
allocation(Person2,R), staff(Person2), Person1!=Person2.
:- not withSomeoneInOffice(Person1), not aloneExemption(Person1),  staff(Person1).

% general preference to sit together with colleagues that are on same projects

sameTeam(Person1,Person2) :- member(Person1,Team), member(Person2,Team), staff(Person1), staff(Person2).
diffTeam(Person1,Person2) :- not sameTeam(Person1,Person2), staff(Person1), staff(Person2).

:-  allocation(Person1,Room), allocation(Person2,Room), diffTeam(Person1,Person2).

% there needs to exist at least one neighbor that is from the same team

neighbourSameTeam(Person1) :- allocation(Person1,Room1), sameTeam(Person1,Person2),
allocation(Person2,Room2), neighbour(Room1,Room2), Room1!=Room2.

:- not neighbourSameTeam(Person), member(Person,xrv), staff(Person).
:- not neighbourSameTeam(Person), member(Person,xre), staff(Person).

#show neighbour/2.
#show sameTeam/2.
#show noneighbourSameTeam/1.

%noneighbourSameTeam(P) :- not neighbourSameTeam(P), member(P,xrv), staff(P).
:- not neighbourSameTeam(Person), member(Person,xrv), staff(Person).
:- not neighbourSameTeam(Person), member(Person,xre), staff(Person).


sameRoomSameProject(P1,P2) :- P1!=P2, allocation(P1,Room),
allocation(P2,Room), roleAllocation(P1,Project), roleAllocation(P2,Project).
%#maximize{1, P1: sameRoomSameProject(P1,P2)}.

%#maximize{1, Person,Room: currentRoom(Person,Room), allocation(Person,Room)}.
% config
movePerson(Person) :- currentRoom(Person,Room1), allocation(Person,Room2), Room1!=Room2.
#minimize{1, P: movePerson(P)}.

% individual preferences wrt colleague  to share room with
%prefCol(gerrit,philipp).
%#maximize{1@1, P1,P2,Room:prefCol(P1,P2),allocation(P1,Room),allocation(P2,Room)}.
% individual preferences wrt room
%{allocation(Person,Room)} :- prefAll(Person,Room).

%#maximize{1@1, Person,Room:prefAll(Person,Room),allocation(Person,Room)}.
