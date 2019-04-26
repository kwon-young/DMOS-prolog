:- module(position, [rightOfSeg/3, leftOfSeg/3, topOfSeg/3, bottomOfSeg/3]).

:- use_module(library(clpfd)).

% utility functions for positional operator
% should go in position.pl
% get right/left/top/bottom most coordinate
rightCoor(coor(X1, Y1), coor(X2, _Y2), coor(X1, Y1)) :-
        X1 #> X2.
rightCoor(coor(X1, _Y1), coor(X2, Y2), coor(X2, Y2)) :-
        X2 #> X1.

leftCoor(coor(X1, Y1), coor(X2, _Y2), coor(X1, Y1)) :-
        X1 #< X2.
leftCoor(coor(X1, _Y1), coor(X2, Y2), coor(X2, Y2)) :-
        X2 #< X1.

topCoor(coor(X1, Y1), coor(_X2, Y2), coor(X1, Y1)) :-
        Y1 #< Y2.
topCoor(coor(_X1, Y1), coor(X2, Y2), coor(X2, Y2)) :-
        Y2 #< Y1.

bottomCoor(coor(X1, Y1), coor(_X2, Y2), coor(X1, Y1)) :-
        Y1 #> Y2.
bottomCoor(coor(_X1, Y1), coor(X2, Y2), coor(X2, Y2)) :-
        Y2 #> Y1.

% construct a little box zone centered on coor
zoneAroundCoor(coor(X, Y), zone(coor(XZone1, YZone1), coor(XZone2, YZone2))) :-
        XZone1 #= X - 1,
        XZone2 #= X + 1,
        YZone1 #= Y - 1,
        YZone2 #= Y + 1.

% positional operators that modify the cursor
% should go in position.pl
% search around the right/left/top/bottom end of a seg
rightOfSeg(seg(CoorDeb, CoorFin), _, cursor(CoorRight, Zone)) :-
        rightCoor(CoorDeb, CoorFin, CoorRight),
        zoneAroundCoor(CoorRight, Zone).

leftOfSeg(seg(CoorDeb, CoorFin), _, cursor(CoorLeft, Zone)) :-
        leftCoor(CoorDeb, CoorFin, CoorLeft),
        zoneAroundCoor(CoorLeft, Zone).

topOfSeg(seg(CoorDeb, CoorFin), _, cursor(CoorTop, Zone)) :-
        topCoor(CoorDeb, CoorFin, CoorTop),
        zoneAroundCoor(CoorTop, Zone).

bottomOfSeg(seg(CoorDeb, CoorFin), _, cursor(CoorBottom, Zone)) :-
        bottomCoor(CoorDeb, CoorFin, CoorBottom),
        zoneAroundCoor(CoorBottom, Zone).
