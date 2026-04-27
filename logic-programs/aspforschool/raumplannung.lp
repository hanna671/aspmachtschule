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
lehrplan(2, ma, 1).
lehrplan(2, ge, 2).
lehrplan(2, de, 3).
lehrplan(2, sp, 2).
lehrplan(3, ma,3).
lehrplan(3, ge, 2).
lehrplan(3, de, 1).
lehrplan(3, eth, 3).
invalid(X):- lehrplan(X,_,_),not klasse(X).
invalid(Y):- lehrplan(_,Y,_) ,not fach(Y).
tag(mo;di;mi;do;fr).
stunde(1..6). 
woche(X,Y):- tag(X),stunde(Y).


X{allokation(K,R,F,T,S):raum(R), woche(T,S)}X:- lehrplan(K, F, X).
invalid(("doppelter raum", R, T, S)) :- allokation(K1, R, F1, T, S), allokation(K2, R, F2, T, S), K1 != K2.
:- invalid(_).
#show allokation/5.


