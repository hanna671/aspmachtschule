
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

% 1. Etage
raum(1,0,0,0).
raum(2,1,0,0).
raum(3,2,0,0).
raum(4,3,0,0).
%raum(5,0,1,0).
%raum(6,1,1,0).
%raum(7,2,1,0).
raum(8,3,1,0).
% sporthallen
raum(9,5,1,0).
% 2. Etage
raum(11,0,0,1).
raum(12,1,0,1).
%raum(13,2,0,1).
%raum(14,3,0,1).
raum(15,0,1,1).
raum(16,1,1,1).
raum(17,2,1,1).
raum(18,3,1,1).
% sporthallen
raum(100,5,1,0).
raum(200,5,2,0).
raum(300,5,3,0).
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
%raum(44,3,0,4).
raum(45,0,1,4).
raum(46,1,1,4).
raum(47,2,1,4).
raum(48,3,1,4).

%raumFach(48, bio). 
%raumFach(N,en) :- fach(en), raum(N,_,_,_), N!=48, N!=32.

raum_fach(4, ch).
raum_fach(4, bio).
raum_fach(8, ch).
raum_fach(3, bio).
raum_fach(2, mu).
raum_fach(1, mu).
raum_fach(18, info).
raum_fach(17, info).
raum_fach(38, geo).
raum_fach(34, geo).
raum_fach(33, ph).
raum_fach(32, ph).
raum_fach(43, ku).
raum_fach(42, ku).
raum_fach(100, sp).
raum_fach(200, sp).
raum_fach(300, sp).

raum_fach(N, eng):- raum(N,_,_,_), N!=4, N!=8, N!=18, N!=17, N!=4, N!=33, N!=32, N!=4, N!=100, N!=200, N!=300.
raum_fach(N, grw):- raum(N,_,_,_), N!=4, N!=8, N!=18, N!=17, N!=4, N!=33, N!=32, N!=4, N!=100, N!=200, N!=300.
raum_fach(N, ge):- raum(N,_,_,_), N!=4, N!=8, N!=18, N!=17, N!=4, N!=33, N!=32, N!=4, N!=100, N!=200, N!=300.
raum_fach(N, de):- raum(N,_,_,_), N!=4, N!=8, N!=18, N!=17, N!=4, N!=33, N!=32, N!=4, N!=100, N!=200, N!=300.
raum_fach(N, ma):- raum(N,_,_,_), N!=4, N!=8, N!=18, N!=17, N!=4, N!=33, N!=32, N!=4, N!=100, N!=200, N!=300.
raum_fach(N, la):- raum(N,_,_,_), N!=4, N!=8, N!=18, N!=17, N!=4, N!=33, N!=32, N!=4, N!=100, N!=200, N!=300.
raum_fach(N, fr):- raum(N,_,_,_), N!=4, N!=8, N!=18, N!=17, N!=4, N!=33, N!=32, N!=4, N!=100, N!=200, N!=300.
raum_fach(N, spa):- raum(N,_,_,_), N!=4, N!=8, N!=18, N!=17, N!=4, N!=33, N!=32, N!=4, N!=100, N!=200, N!=300.
raum_fach(N, religion):- raum(N,_,_,_), N!=4, N!=8, N!=18, N!=17, N!=4, N!=33, N!=32, N!=4, N!=100, N!=200, N!=300.
raum_fach(N, eth):- raum(N,_,_,_), N!=4, N!=8, N!=18, N!=17, N!=4, N!=33, N!=32, N!=4, N!=100, N!=200, N!=300.
raum_fach(N, lern):- raum(N,_,_,_), N!=4, N!=8, N!=18, N!=17, N!=4, N!=33, N!=32, N!=4, N!=100, N!=200, N!=300.
raum_fach(N, profil):- raum(N,_,_,_), N!=4, N!=8, N!=18, N!=17, N!=4, N!=33, N!=32, N!=4, N!=100, N!=200, N!=300.


dist_x(R,R1,DX):- X-X1=DX, X>=X1, raum(R,X,_,_), raum(R1,X1,_,_).
dist_x(R,R1,DX):- X1-X=DX, X<X1, raum(R,X,_,_), raum(R1,X1,_,_).

dist_y(R,R1,DY):- Y-Y1=DY, Y>=Y1, raum(R,_,Y,_), raum(R1,_,Y1,_).
dist_y(R,R1,DY):- Y1-Y=DY, Y<Y1, raum(R,_,Y,_), raum(R1,_,Y1,_).

dist_z(R,R1,DZ):- Z-Z1=DZ, Z>=Z1, raum(R,_,_,Z), raum(R1,_,_,Z1).
dist_z(R,R1,DZ):- Z1-Z=DZ, Z<Z1, raum(R,_,_,Z), raum(R1,_,_,Z1).

dist(R,R1,D):- D=DY+DX+DZ*4, dist_z(R,R1,DZ), dist_y(R,R1,DY), dist_x(R,R1,DX).

dist_x(R,R1,X) :- dist_x(R,R1,X).
dist_y(R,R1,Y) :- dist_y(R,R1,Y).
dist_z(R,R1,Z) :- dist_z(R,R1,Z).
dist(R,R1,D) :- dist(R,R1,D).

%klasse(81). klasse(82). klasse(83). klasse(84). klasse(85). klasse(86).
%klasse(91). klasse(92). klasse(93). klasse(94). klasse(95).
klasse(101). klasse(102).% klasse(103). klasse(104).


fach(bio;info;ku;eng;geo;sp;grw;ge;de;ma;ch;ph;la;fr;spa;mu;eth;lern;profil).

%lehrplan(K,M,F,_), klasse(K), fach(F).
lehrplan(K,ku,1):- klasse(K).
lehrplan(K,eng,3):- klasse(K).
lehrplan(K,profil,2):- klasse(K).
lehrplan(K,sp,2):- klasse(K).
lehrplan(K,ge,2):- klasse(K).
lehrplan(K,ch,2):- klasse(K).
lehrplan(K,ph,2):- klasse(K).
lehrplan(K,ma,4):- klasse(K).
lehrplan(K,eth,2):- klasse(K).

lehrplan(81,bio,1).
lehrplan(82,bio,1).
lehrplan(83,bio,1).
lehrplan(84,bio,1).
lehrplan(85,bio,1).
lehrplan(86,bio,1).

lehrplan(91,bio,2).
lehrplan(92,bio,2).
lehrplan(93,bio,2).
lehrplan(94,bio,2).
lehrplan(95,bio,2).

lehrplan(101,bio,2).
lehrplan(102,bio,2).
lehrplan(103,bio,2).
lehrplan(104,bio,2).


lehrplan(81,geo,1).
lehrplan(82,geo,1).
lehrplan(83,geo,1).
lehrplan(84,geo,1).
lehrplan(85,geo,1).
lehrplan(86,geo,1).

lehrplan(91,geo,1).
lehrplan(92,geo,1).
lehrplan(93,geo,1).
lehrplan(94,geo,1).
lehrplan(95,geo,1).

lehrplan(101,geo,2).
lehrplan(102,geo,2).
lehrplan(103,geo,2).
lehrplan(104,geo,2).

lehrplan(81,grw,1).
lehrplan(82,grw,1).
lehrplan(83,grw,1).
lehrplan(84,grw,1).
lehrplan(85,grw,1).
lehrplan(86,grw,1).

lehrplan(91,grw,2).
lehrplan(92,grw,2).
lehrplan(93,grw,2).
lehrplan(94,grw,2).
lehrplan(95,grw,2).

lehrplan(101,grw,2).
lehrplan(102,grw,2).
lehrplan(103,grw,2).
lehrplan(104,grw,2).

lehrplan(81,de,4).
lehrplan(82,de,4).
lehrplan(83,de,4).
lehrplan(84,de,4).
lehrplan(85,de,4).
lehrplan(86,de,4).

lehrplan(91,de,3).
lehrplan(92,de,3).
lehrplan(93,de,3).
lehrplan(94,de,3).
lehrplan(95,de,3).

lehrplan(101,de,4).
lehrplan(102,de,4).
lehrplan(103,de,4).
lehrplan(104,de,4).

lehrplan(81,lern,1).
lehrplan(82,lern,1).
lehrplan(83,lern,1).
lehrplan(84,lern,1).
lehrplan(85,lern,1).
lehrplan(86,lern,1).

lehrplan(81,la,3).
lehrplan(82,fr,3).
lehrplan(83,fr,3).
lehrplan(84,spa,3).
% bei 84 keine ahnung
lehrplan(85,spa, 3).
lehrplan(86,spa,3).
lehrplan(91,la,3).
lehrplan(92,fr,3).
lehrplan(93,fr,3).
lehrplan(94,spa,3).
lehrplan(95,spa,3).
lehrplan(101,la,3).
lehrplan(102,fr,3).
lehrplan(103,fr,3).
lehrplan(104,spa,3).

invalid(K):- lehrplan(K,_,_),not klasse(K).
invalid(Y):- lehrplan(_,Y,_) ,not fach(Y).
%tag(mo;di;mi;do;fr).
tag(mo).
tag(di).
tag(mi).
tag(do).
tag(fr).
stunde(1..6). 
woche(X,Y):- tag(X),stunde(Y).
%fehlender_lehrer(F):- lehrplan(_,F,_), not fehlender_lehrer_helfer(F).
%fehlender_lehrer_helfer(F):- lehrer(L,F).

#show invalid/1.

% choice rules
1{allokation(K,R,F,T,S,L):lehrer(L,F), raum_fach(R,F), woche(T,S)}1:- lehrplan(K, F, X), X=1.
2{allokation(K,R,F,T,S,L):lehrer(L,F), raum_fach(R,F), woche(T,S)}2:- lehrplan(K, F, X), X=2.
3{allokation(K,R,F,T,S,L):lehrer(L,F), raum_fach(R,F), woche(T,S)}3:- lehrplan(K, F, X), X=3.
%4{allokation(K,R,F,T,S,L):lehrer(L,F), raum_fach(R,F), woche(T,S)}4:- lehrplan(K, F, X), X=4.
%X{allokation(K,R,F,T,S,L):lehrer(L,F), raum_fach(R,F), woche(T,S)}X:- lehrplan(K, F, X).

% integrity constraints
:- allokation(K1, M1, R, F1, T, S, L), allokation(K2, M, R, F2, T, S, L), K1 != K2, lehrer(L,F).
:- allokation(K, R1, F1, T, S, L1), allokation(K, R, F, T, S, L), F!=F1, lehrer(L,F), klasse(K).
:- allokation(K, R1, F1, T, S, L1), allokation(K, R, F, T, S, L), R1!=R, lehrer(L,F), klasse(K).
:- allokation(K, R1, F1, T, S, L1), allokation(K, R, F, T, S, L), L1!=L, lehrer(L,F), klasse(K).


wegkosten(K, D, T, S):- allokation(K, R1, F1, T, S1, L1), allokation(K, R, F, T, S, L), dist(R1, R, D), S1=S+1.
vollstaendigedist(K,G):- #sum{ D ,T, S : wegkosten(K, D, T, S)}= G, klasse(K).
#minimize{G,K:vollstaendigedist(K,G)}.


wegkostenLehrer(L, D, T, S):- allokation(K, R1, F1, T, S1, L1), allokation(K, R, F, T, S, L), dist(R1, R, D), S1=S+1.
vollstaendigedistLehrer(L,G):- #sum{ D ,T, S : wegkosten(K, D, T, S)}= G, lehrer(L).
#minimize{G,L:vollstaendigedistLehrer(L,G)}.

%#maximize{D,(K, M, T, S1) : klasse_zeitpunkt_raum(K, M, T, S1, R1), klasse_zeitpunkt_raum(K, M, T, S2, R2), dist(R1, R2, D), S2=S1+1, stunde(S2)}. 


% ein block ist 2 stunden vom gleichen fach hintereinnander, vielleicht so: 
block(F, S, S1, T, K, M, L):- allokation(K, M, R, F, T, S ,L), allokation(K, M, R, F, T, S1, L), S1=S+1, S1!=6.

%vielleicht noch summe von blöcken bilden,oder vielleicht zählen?: 
sumblock(B):- #sum{S, F, S1, T, K, L: block(F, S, S1, T, K, L)}=B.
#maximize{B: sumblock(B)}.

%nur maximal 2mal das gleiche fach
:-block(F, S, S1, T, K, M, L), block(F, S1, S2, T, K, L), S+2=S1+1=S2.

%homeoffice:
:- lehrer(L, F), #count{ T, S : allokation(K, M, R, F, T, S, L) } > 4.


%#show allokation/5.
%#show vollstaendigedist/2.
%#show wegkosten/4.
%show fehlender_lehrer/1.
#show allokation/7.

