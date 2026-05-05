% 1. Etage
raum(1,0,0,0).
raum(2,1,0,0).
raum(3,2,0,0).
raum(4,3,0,0).
raum(5,0,1,0).
raum(6,1,1,0).
raum(7,2,1,0).
raum(8,3,1,0).
% 2. Etage
raum(11,0,0,1).
raum(12,1,0,1).
raum(13,2,0,1).
raum(14,3,0,1).
raum(15,0,1,1).
raum(16,1,1,1).
raum(17,2,1,1).
raum(18,3,1,1).
% 3. Etage
raum(21,0,0,2).
raum(22,1,0,2).
raum(23,2,0,2).
raum(24,3,0,2).
raum(25,0,1,2).
raum(26,1,1,2).
raum(27,2,1,2).
raum(28,3,1,2).
% 4.Etage
raum(31,0,0,3).
raum(32,1,0,3).
raum(33,2,0,3).
raum(34,3,0,3).
raum(35,0,1,3).
raum(36,1,1,3).
raum(37,2,1,3).
raum(38,3,1,3).
% 5. Etage
raum(41,0,0,4).
raum(42,1,0,4).
raum(43,2,0,4).
raum(44,3,0,4).
raum(45,0,1,4).
raum(46,1,1,4).
raum(47,2,1,4).
raum(48,3,1,4).

% wie ist das wenn man die Etage nicht wechselt? es werden dennoch +4 distanz hinzugefügt 
%dist(R,R1,D):- Y-Y1=J, X-X1=J1, J2= 4*(Z-Z1), J2+J1+J=D, Y!=Y1, X!=X1, Z>Z1, raum(R,X,Y,Z), raum(R1,X1,Y1,Z1).
%dist(R,R1,D):- Y-Y1=J, X-X1=J1, J2= 4*(Z1-Z), J2+J1+J=D, Y!=Y1, X!=X1, Z<Z1, raum(R,X,Y,Z), raum(R1,X1,Y1,Z1).
%dist(R,R1,D):- X-X1=J,Y-Y1=J, J2= 4*(Z1-Z), J2+J1+J=D, Y!=Y1, X!=X1, Z<Z1, raum(R,X,Y,Z), raum(R1,X1,Y,Z).
dist_x(R,R1,DX):- X-X1=DX, X>X1, raum(R,X,Y,Z), raum(R1,X1,Y,Z).
dist_x(R,R1,DX):- X1-X=DX, X<X1, raum(R,X,Y,Z), raum(R1,X1,Y,Z).
dist_y(R,R1,DY):- Y-Y1=DY, Y>Y1, raum(R,X,Y,Z), raum(R1,X,Y1,Z).
dist_y(R,R1,DY):- Y1-Y=DY, Y<Y1, raum(R,X,Y,Z), raum(R1,X,Y1,Z).
dist_z(R,R1,DZ):- Z-Z1=DZ, Z>Z1, raum(R,X,Y,Z), raum(R1,X,Y,Z1).
dist_z(R,R1,DZ):- Z1-Z=DZ, Z<Z1, raum(R,X,Y,Z), raum(R1,X,Y,Z1).
dist(R,R1,D):- D=DX+DY+DZ*4, dist_x(R,R1,DX), dist_y(R,R1,DY), dist_z(R,R1,DZ).
%dist(R,R1,D):- D=DY+ DZ*4, dist_z(R,R1,DZ), dist_y(R,R1,DY).
dist(R,R,0) :- raum(R,X,Y,Z).
dist(X,Y,Z) :- dist(Y,X,Z).

%klasse(8,a). klasse(8,b). klasse(8,c). klasse(8,d). klasse(8,e). klasse(8,f).
%klasse(9,a). klasse(9,b). klasse(9,c). klasse(9,d). klasse(9,e).
klasse(10,a). klasse(10,b). klasse(10,c). klasse(10,d).

fach(bio;info;ku;eng;geo;sp;grw;ge;de;ma;ch;ph;la;fr;spa;mu;religion;eth;lern,profil).


%lehrplan(K,M,F,_), klasse(K,M), fach(F).
lehrplan(K,M,ku,1):- klasse(K,M).
lehrplan(K,M,eng,3):- klasse(K,M).
lehrplan(K,M,profil,2):- klasse(K,M).
lehrplan(K,M,sp,2):- klasse(K,M).
lehrplan(K,M,ge,2):- klasse(K,M).
lehrplan(K,M,ch,2):- klasse(K,M).
lehrplan(K,M,ph,2):- klasse(K,M).
lehrplan(K,M,ma,4):- klasse(K,M).
lehrplan(K,M,eth,2):- klasse(K,M).

lehrplan(8,M,bio,1):- klasse(K,M).
lehrplan(9,M,bio,2):- klasse(K,M).
lehrplan(10,M,bio,2):- klasse(K,M).

lehrplan(8,M,geo,1):- klasse(K,M).
lehrplan(9,M,geo,1):- klasse(K,M).
lehrplan(10,M,geo,2):- klasse(K,M).

lehrplan(8,M,grw,1):- klasse(K,M).
lehrplan(9,M,grw,2):- klasse(K,M).
lehrplan(10,M,grw,2):- klasse(K,M).

lehrplan(8,M,de,4):- klasse(K,M).
lehrplan(9,M,de,3):- klasse(K,M).
lehrplan(10,M,de,4):- klasse(K,M).

lehrplan(8,M,lern,1):- klasse(K,M).

lehrplan(8,a,la,3).
lehrplan(8,b,fr,3).
lehrplan(8,c,fr,3).
lehrplan(8,d,spa,3).
% bei 8e keine ahnung
lehrplan(8,e,spa, 3).
lehrplan(8,f,spa,3).
lehrplan(9,a,la,3).
lehrplan(9,b,fr,3).
lehrplan(9,c,fr,3).
lehrplan(9,d,spa,3).
lehrplan(9,e,spa,3).
lehrplan(10,a,la,3).
lehrplan(10,b,fr,3).
lehrplan(10,c,fr,3).
lehrplan(10,d,spa,3).



invalid(X):- lehrplan(X,M,_,_),not klasse(X,M).
invalid(Y):- lehrplan(_,_,Y,_) ,not fach(Y).
%tag(mo;di;mi;do;fr).
tag(mo).
tag(di).
tag(mi).
tag(do).
tag(fr).
stunde(1..6). 
woche(X,Y):- tag(X),stunde(Y).
fehlender_lehrer(F):- lehrplan(_,_,F,_), not fehlender_lehrer_helfer(F).
fehlender_lehrer_helfer(F):- lehrer(L,F).
%1 { klasse_fach_lehrer(K, M, F, L) : lehrer(L, F) } 1 :- klasse(K, M), lehrplan(K, M, F, _).
%0 { klasse_zeitpunkt_raum(K, M, T, S, R) : raum(R, _, _) } 1 :- woche(T, S), klasse(K, M).
%0 { klasse_zeitpunkt_fach(K, M, T, S, F) : fach(F) } 1 :- woche(T, S), klasse(K, M).
%X { klasse_zeitpunkt_fach(K, M, T, S, F) : woche(T, S)} X :- lehrplan(K, M, F, X).


%allokation(K, M, R, F, T, S, L) :- klasse_fach_lehrer(K, M, F, L), klasse_zeitpunkt_raum(K, M, T, S, R), klasse_zeitpunkt_fach(K, M, T, S, F).

% Grounding dauert zu lange:
%{allokation(K,R,F,T,S,L):lehrer(L,F), raum(R,_,_,_), woche(T,S)}X:- lehrplan(K,M, F, X).
%invalid(("doppelter raum", R, T, S)) :- allokation(K1, R, F1, T, S, L), allokation(K2, R, F2, T, S, L), K1 != K2, lehrer(L,F).
%:- invalid(_).

%wegkosten(K, D, T, S):- allokation(K, M, R1, F1, T, S1, L1), allokation(K, , R, F, T, S, L), dist(R1, R, D), S1=S+1, stunde(S1), klasse(K,M), lehrer(L,F).
%vollstaendigedist(K,G):- #sum{ D ,T, S : wegkosten(K, D, T, S)}= G, klasse(K).
%:- allokation(K, M, R1, F1, T, S, L1), allokation(K, M, R, F, T, S, L), F!=F1, lehrer(L,F), klasse(K,M).
%:- allokation(K, M, R1, F1, T, S, L1), allokation(K, M, R, F, T, S, L), R1!=R, lehrer(L,F), klasse(K,M).
%:- allokation(K, M, R1, F1, T, S, L1), allokation(K, M, R, F, T, S, L), L1!=L, lehrer(L,F), klasse(K,M).
%#minimize{G,K:vollstaendigedist(K,G)}.

%#maximize{D,(K, M, T, S1) : klasse_zeitpunkt_raum(K, M, T, S1, R1), klasse_zeitpunkt_raum(K, M, T, S2, R2), dist(R1, R2, D), S2=S1+1, stunde(S2)}. 


lehrer(ammstein_bahmann, ge).
lehrer(ammstein_bahmann, mu).
lehrer(bergmann, de).
lehrer(bergmann, ku).
lehrer(birnbaum, spa).
lehrer(birnbaum, geo).
lehrer(brewer, mu).
lehrer(brewer, eng).
lehrer(brueckner, eng).
lehrer(brueckner, spa).
lehrer(croy, ku).
lehrer(croy, eth).
lehrer(dreyer, info).
lehrer(dreyer, ma).
lehrer(dessel, eng).
lehrer(endesfelder, ph).
lehrer(endesfelder, ma).
lehrer(erbe, reli).
lehrer(ferme, ku).
lehrer(ferme, eng).
lehrer(forsbohm, ph).
lehrer(forsbohm, info).
lehrer(frey, de).
lehrer(frick, fr).
lehrer(frick, eng).
lehrer(geyer, ch).
lehrer(hentschel, de).
lehrer(hentschel, ge).
lehrer(hergert, info).
lehrer(hergert, ma).
lehrer(herzog, fr).
lehrer(herzog, la).
lehrer(herzog, geo).
lehrer(jacob, sp).
lehrer(jacob, grw).
lehrer(thiele, grw).
lehrer(thiele, ge).
lehrer(just, ge).
lehrer(just, de).
lehrer(kalauch, eth).
lehrer(kalauch, sp).
lehrer(ketzler, de).
lehrer(ketzler, grw).
lehrer(keyn, ph).
lehrer(keyn, ma).
lehrer(klaffenbach, geo).
lehrer(klaffenbach, eng).
lehrer(klinger, fr).
lehrer(klinger, ch).
lehrer(kraeker, ph).
lehrer(kraeker, ma).
lehrer(kraut, ch).
lehrer(kraut, spa).
lehrer(kuehn, grw).
lehrer(kuehn, eng).
lehrer(schmidt, fr).
lehrer(schmidt, sp).
lehrer(thiesen, ge).
lehrer(thiesen, la).
lehrer(meinicke, bio).
lehrer(meinicke, ma).
lehrer(petzold, de).
lehrer(petzold, eth).
lehrer(rehm, bio).
lehrer(rehm, eng).
lehrer(welde, reli).
lehrer(kraut, ch).
lehrer(kraut, spa).
lehrer(super_lehrer, lern).
lehrer(super_lehrer, profil).

%wegkostenlehrer(L,D,T,S):- allokation(K,M,R1,F1,T,S1,L1), allokation(K,M,R,F,T,S,L), dist(R1,R,D), S1=S+1, stunde(S1), klasse(K,M), lehrer(L,F).
%vollstaendigedistlehrer(L,V):- #sum{D,T,S: wegkostenlehrer(L,D,T,S)}=V ,lehrer(L,F).
%#minimize{V,L: vollstaendigedistlehrer(L,V)}.

% ein block ist 2 stunden vom gleichen fach hintereinnander, vielleicht so: 
 %block(F, S, S1, T, K, M, L):- allokation(K, M, R, F, T, S ,L), allokation(K, M, R, F, T, S1, L), S1=S+1, S1!=6.

%vielleicht noch summe von blöcken bilden,oder vielleicht zählen?: 
%sumblock(B):- #sum{S, F, S1, T, K, L: block(F, S, S1, T, K, L)}=B.
%#maximize{B: sumblock(B)}.

%nur maximal 2mal das gleiche fach
%:-block(F, S, S1, T, K, M, L), block(F, S1, S2, T, K, L), S+2=S1+1=S2.

%homeoffice:
%:- lehrer(L, F), #count{ T, S : allokation(K, M, R, F, T, S, L) } > 4.


%#show allokation/5.
%#show vollstaendigedist/2.
%#show wegkosten/4.
%show fehlender_lehrer/1.
#show falsch/2.
