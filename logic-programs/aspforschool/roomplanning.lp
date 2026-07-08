
teacher(ammstein_bahmann, ge).
teacher(ammstein_bahmann, mu).
teacher(bergmann, de).
teacher(bergmann, ku).
teacher(birnbaum, spa).
teacher(birnbaum, geo).
teacher(brewer, mu).
teacher(brewer, eng).
teacher(brueckner, eng).
teacher(brueckner, spa).
teacher(croy, ku).
teacher(croy, eth).
teacher(dreyer, info).
teacher(dreyer, ma).
teacher(dessel, eng).
teacher(endesfelder, ph).
teacher(endesfelder, ma).
teacher(erbe, reli).
teacher(ferme, ku).
teacher(ferme, eng).
teacher(forsbohm, ph).
teacher(forsbohm, info).
teacher(frey, de).
teacher(frick, fr).
teacher(frick, eng).
teacher(geyer, ch).
teacher(hentschel, de).
teacher(hentschel, ge).
teacher(hergert, info).
teacher(hergert, ma).
teacher(herzog, fr).
teacher(herzog, la).
teacher(herzog, geo).
teacher(jacob, sp).
teacher(jacob, grw).
teacher(thiele, grw).
teacher(thiele, ge).
teacher(just, ge).
teacher(just, de).
teacher(kalauch, eth).
teacher(kalauch, sp).
teacher(ketzler, de).
teacher(ketzler, grw).
teacher(keyn, ph).
teacher(keyn, ma).
teacher(klaffenbach, geo).
teacher(klaffenbach, eng).
teacher(klinger, fr).
teacher(klinger, ch).
teacher(kraeker, ph).
teacher(kraeker, ma).
teacher(kraut, ch).
teacher(kraut, spa).
teacher(kuehn, grw).
teacher(kuehn, eng).
teacher(schmidt, fr).
teacher(schmidt, sp).
teacher(thiesen, ge).
teacher(thiesen, la).
teacher(meinicke, bio).
teacher(meinicke, ma).
teacher(petzold, de).
teacher(petzold, eth).
teacher(rehm, bio).
teacher(rehm, eng).
teacher(welde, reli).
teacher(kraut, ch).
teacher(kraut, spa).
teacher(super_teacher, lern).
teacher(super_teacher, profil).

% 1. Etage
room(1,0,0,0).
room(2,1,0,0).
room(3,2,0,0).
room(4,3,0,0).
%room(5,0,1,0).
%room(6,1,1,0).
%room(7,2,1,0).
room(8,3,1,0).
% sporthallen
room(9,5,1,0).
% 2. Etage
room(11,0,0,1).
room(12,1,0,1).
%room(13,2,0,1).
%room(14,3,0,1).
room(15,0,1,1).
room(16,1,1,1).
room(17,2,1,1).
room(18,3,1,1).
% sporthallen
room(100,5,1,0).
room(200,5,2,0).
room(300,5,3,0).
% 3. Etage
room(21,0,0,2).
room(22,1,0,2).
room(23,2,0,2).
room(24,3,0,2).
room(25,0,1,2).
room(26,1,1,2).
room(27,2,1,2).
room(28,3,1,2).
% 4.Etage
room(31,0,0,3).
room(32,1,0,3).
room(33,2,0,3).
room(34,3,0,3).
room(35,0,1,3).
room(36,1,1,3).
room(37,2,1,3).
room(38,3,1,3).
% 5. Etage
room(41,0,0,4).
room(42,1,0,4).
room(43,2,0,4).
%room(44,3,0,4).
room(45,0,1,4).
room(46,1,1,4).
room(47,2,1,4).
room(48,3,1,4).

%room_subject(48, bio).
%room_subject(N,en) :- subject(en), room(N,_,_,_), N!=48, N!=32.

room_subject(4, ch).
room_subject(4, bio).
room_subject(8, ch).
room_subject(3, bio).
room_subject(2, mu).
room_subject(1, mu).
room_subject(18, info).
room_subject(17, info).
room_subject(38, geo).
room_subject(34, geo).
room_subject(33, ph).
room_subject(32, ph).
room_subject(43, ku).
room_subject(42, ku).
room_subject(100, sp).
room_subject(200, sp).
room_subject(300, sp).

% Define specialized rooms once
specialized_room(1;2;3;4;8;17;18;32;33;34;38;42;43;100;200;300).

% General subjects can use any non-specialized room
room_subject(N, eng):- room(N,_,_,_), not specialized_room(N).
room_subject(N, grw):- room(N,_,_,_), not specialized_room(N).
room_subject(N, ge):- room(N,_,_,_), not specialized_room(N).
room_subject(N, de):- room(N,_,_,_), not specialized_room(N).
room_subject(N, ma):- room(N,_,_,_), not specialized_room(N).
room_subject(N, la):- room(N,_,_,_), not specialized_room(N).
room_subject(N, fr):- room(N,_,_,_), not specialized_room(N).
room_subject(N, spa):- room(N,_,_,_), not specialized_room(N).
room_subject(N, religion):- room(N,_,_,_), not specialized_room(N).
room_subject(N, eth):- room(N,_,_,_), not specialized_room(N).
room_subject(N, lern):- room(N,_,_,_), not specialized_room(N).
room_subject(N, profil):- room(N,_,_,_), not specialized_room(N).


% Simplified distance calculation (absolute value using conditional)
dist_x(R,R1,DX):- room(R,X,_,_), room(R1,X1,_,_), X>=X1, DX=X-X1.
dist_x(R,R1,DX):- room(R,X,_,_), room(R1,X1,_,_), X<X1, DX=X1-X.

dist_y(R,R1,DY):- room(R,_,Y,_), room(R1,_,Y1,_), Y>=Y1, DY=Y-Y1.
dist_y(R,R1,DY):- room(R,_,Y,_), room(R1,_,Y1,_), Y<Y1, DY=Y1-Y.

dist_z(R,R1,DZ):- room(R,_,_,Z), room(R1,_,_,Z1), Z>=Z1, DZ=Z-Z1.
dist_z(R,R1,DZ):- room(R,_,_,Z), room(R1,_,_,Z1), Z<Z1, DZ=Z1-Z.

dist(R,R1,D):- dist_x(R,R1,DX), dist_y(R,R1,DY), dist_z(R,R1,DZ), D=DX+DY+DZ*4.

%class(81). class(82). class(83). class(84). class(85). class(86).
%class(91). class(92). class(93). class(94). class(95).
class(101). class(102).% class(103). class(104).


subject(bio;info;ku;eng;geo;sp;grw;ge;de;ma;ch;ph;la;fr;spa;mu;eth;lern;profil).

%curriculum(K,M,F,_), class(K), subject(F).
curriculum(K,ku,1):- class(K).
curriculum(K,eng,3):- class(K).
curriculum(K,profil,2):- class(K).
curriculum(K,sp,2):- class(K).
curriculum(K,ge,2):- class(K).
curriculum(K,ch,2):- class(K).
curriculum(K,ph,2):- class(K).
curriculum(K,ma,4):- class(K).
curriculum(K,eth,2):- class(K).

curriculum(81,bio,1).
curriculum(82,bio,1).
curriculum(83,bio,1).
curriculum(84,bio,1).
curriculum(85,bio,1).
curriculum(86,bio,1).

curriculum(91,bio,2).
curriculum(92,bio,2).
curriculum(93,bio,2).
curriculum(94,bio,2).
curriculum(95,bio,2).

curriculum(101,bio,2).
curriculum(102,bio,2).
curriculum(103,bio,2).
curriculum(104,bio,2).


curriculum(81,geo,1).
curriculum(82,geo,1).
curriculum(83,geo,1).
curriculum(84,geo,1).
curriculum(85,geo,1).
curriculum(86,geo,1).

curriculum(91,geo,1).
curriculum(92,geo,1).
curriculum(93,geo,1).
curriculum(94,geo,1).
curriculum(95,geo,1).

curriculum(101,geo,2).
curriculum(102,geo,2).
curriculum(103,geo,2).
curriculum(104,geo,2).

curriculum(81,grw,1).
curriculum(82,grw,1).
curriculum(83,grw,1).
curriculum(84,grw,1).
curriculum(85,grw,1).
curriculum(86,grw,1).

curriculum(91,grw,2).
curriculum(92,grw,2).
curriculum(93,grw,2).
curriculum(94,grw,2).
curriculum(95,grw,2).

curriculum(101,grw,2).
curriculum(102,grw,2).
curriculum(103,grw,2).
curriculum(104,grw,2).

curriculum(81,de,4).
curriculum(82,de,4).
curriculum(83,de,4).
curriculum(84,de,4).
curriculum(85,de,4).
curriculum(86,de,4).

curriculum(91,de,3).
curriculum(92,de,3).
curriculum(93,de,3).
curriculum(94,de,3).
curriculum(95,de,3).

curriculum(101,de,4).
curriculum(102,de,4).
curriculum(103,de,4).
curriculum(104,de,4).

curriculum(81,lern,1).
curriculum(82,lern,1).
curriculum(83,lern,1).
curriculum(84,lern,1).
curriculum(85,lern,1).
curriculum(86,lern,1).

curriculum(81,la,3).
curriculum(82,fr,3).
curriculum(83,fr,3).
curriculum(84,spa,3).
% bei 84 keine ahnung
curriculum(85,spa, 3).
curriculum(86,spa,3).
curriculum(91,la,3).
curriculum(92,fr,3).
curriculum(93,fr,3).
curriculum(94,spa,3).
curriculum(95,spa,3).
curriculum(101,la,3).
curriculum(102,fr,3).
curriculum(103,fr,3).
curriculum(104,spa,3).

invalid(K):- curriculum(K,_,_),not class(K).
invalid(Y):- curriculum(_,Y,_) ,not subject(Y).
%day(mo;di;mi;do;fr).
day(mo).
day(di).
day(mi).
day(do).
day(fr).
hour(1..6).
week(X,Y):- day(X),hour(Y).
%missing_teacher(F):- curriculum(_,F,_), not missing_teacher_helper(F).
%missing_teacher_helper(F):- teacher(L,F).

#show invalid/1.

1{allocation(K,R,F,T,S,L):teacher(L,F), room_subject(R,F), week(T,S)}3:- curriculum(K, F, X), X=1.
%2{allocation(K,R,F,T,S,L):teacher(L,F), room_subject(R,F), week(T,S)}2:- curriculum(K, F, X), X=2.
%3{allocation(K,R,F,T,S,L):teacher(L,F), room_subject(R,F), week(T,S)}3:- curriculum(K, F, X), X=3.
%4{allocation(K,R,F,T,S,L):teacher(L,F), room_subject(R,F), week(T,S)}4:- curriculum(K, F, X), X=4.
%X{allocation(K,R,F,T,S,L):teacher(L,F), room_subject(R,F), week(T,S)}X:- curriculum(K, F, X).

% integrity constraints
:- allocation(K1, M1, R, F1, T, S, L), allocation(K2, M, R, F2, T, S, L), K1 != K2, teacher(L,F).
:- allocation(K, R1, F1, T, S, L1), allocation(K, R, F, T, S, L), F!=F1, teacher(L,F), class(K).
:- allocation(K, R1, F1, T, S, L1), allocation(K, R, F, T, S, L), R1!=R, teacher(L,F), class(K).
:- allocation(K, R1, F1, T, S, L1), allocation(K, R, F, T, S, L), L1!=L, teacher(L,F), class(K).


travel_cost(K, D, T, S):- allocation(K, R1, F1, T, S1, L1), allocation(K, R, F, T, S, L), dist(R1, R, D), S1=S+1.
total_distance(K,G):- #sum{ D ,T, S : travel_cost(K, D, T, S)}= G, class(K).
#minimize{G,K:total_distance(K,G)}.


travel_cost_teacher(L, D, T, S):- allocation(K, R1, F1, T, S1, L1), allocation(K, R, F, T, S, L), dist(R1, R, D), S1=S+1.
total_distance_teacher(L,G):- #sum{ D ,T, S : travel_cost(K, D, T, S)}= G, teacher(L).
#minimize{G,L:total_distance_teacher(L,G)}.

#maximize{D,(K, M, T, S1) : class_time_room(K, M, T, S1, R1), class_time_room(K, M, T, S2, R2), dist(R1, R2, D), S2=S1+1, hour(S2)}.

% one block is 2 hour from the same subject
block(F, S, S1, T, K, M, L):- allocation(K, M, R, F, T, S ,L), allocation(K, M, R, F, T, S1, L), S1=S+1, S!=6.

%take sums of blocks or count them
sum_blocks(B):- #sum{S, F, S1, T, K, L: block(F, S, S1, T, K, L)}=B.
#maximize{B: sum_blocks(B)}.

%but maximally two times the same subjects
:-block(F, S, S1, T, K, M, L), block(F, S1, S2, T, K, L), S+2=S1+1=S2.

%homeoffice:
%:- teacher(L, F), #count{ T, S : allocation(K, M, R, F, T, S, L) } > 4.


%#show allocation/5.
%#show total_distance/2.
%#show travel_cost/4.
%show missing_teacher/1.
#show allocation/7.

