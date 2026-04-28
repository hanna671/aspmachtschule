raum(1..3).
dist(1,2,1).
dist(1,3,2).
dist(2,3,1).
dist(X,X,0) :- raum(X).
dist(X,Y,Z):-dist(Y,X,Z).
klasse(1). klasse(2). klasse(3).
fach(ma).
fach(ge).
fach(de).
fach(sp).
fach(eth).
lehrplan(1, ma, 2).
lehrplan(1, ge,2).
lehrplan(1, de, 1).
lehrplan(1, sp, 2).
lehrplan(2, sp, 2).
lehrplan(3, ma,3).
lehrplan(3, ge, 2).
lehrplan(3, de, 1).
lehrplan(3, eth, 3).
invalid(X):- lehrplan(X,_,_),not klasse(X).
invalid(Y):- lehrplan(_,Y,_) ,not fach(Y).
tag(mo;di;mi).
%;do;fr).
stunde(1..6). 
woche(X,Y):- tag(X),stunde(Y).


X{allokation(K,R,F,T,S,L):lehrer(L,F), raum(R), woche(T,S)}X:- lehrplan(K, F, X).
invalid(("doppelter raum", R, T, S)) :- allokation(K1, R, F1, T, S, L), allokation(K2, R, F2, T, S, L), K1 != K2, lehrer(L,F).
:- invalid(_).
wegkosten(K, D, T, S):- allokation(K, R1, F1, T, S1, L1), allokation(K, R, F, T, S, L), dist(R1, R, D), S1=S+1, stunde(S1), klasse(K), lehrer(L,F).
vollstaendigedist(K,G):- #sum{ D ,T, S : wegkosten(K, D, T, S)}= G, klasse(K).
:- allokation(K, R1, F1, T, S, L1), allokation(K, R, F, T, S, L), F!=F1, lehrer(L,F), klasse(K).
:- allokation(K, R1, F1, T, S, L1), allokation(K, R, F, T, S, L), R1!=R, lehrer(L,F), klasse(K).
:- allokation(K, R1, F1, T, S, L1), allokation(K, R, F, T, S, L), L1!=L, lehrer(L,F), klasse(K).
#minimize{G,K:vollstaendigedist(K,G)}.

lehrer(1,ma).
lehrer(2,de).
lehrer(3,ge).
lehrer(4,eth).
lehrer(5,sp).

wegkostenl(L,D,T,S):- allokation(K,R1,F1,T,S1,L1), allokation(K,R,F,T,D,L), dist(R1,R,D), S1=S+1, stunde(S1), klasse(K), lehrer(L,F).




%#show allokation/5.
%#show vollstaendigedist/1.
%#show wegkosten/4.
