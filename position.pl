:- module(position, [pageEntiere/2, rightOfSeg/3, leftOfSeg/3, topOfSeg/3,
                     bottomOfSeg/3]).

:- use_module(library(clpfd)).

% utility functions for positional operator

pageEntiere(CurIn, CurOut) :-
    CurIn = cursor(_, _, CurEl, _),
    CurOut = cursor(0, 0, CurEl, Zone),
    Zone = zone(0, 0, 100, 100).

bottomCoor(coor(X1, Y1), coor(_X2, Y2), coor(X1, Y1)) :-
    Y1 #> Y2.
bottomCoor(coor(_X1, Y1), coor(X2, Y2), coor(X2, Y2)) :-
    Y2 #> Y1.

% construct a little box zone centered on coor
zoneAroundCoor(coor(X, Y), zone(XZone1, YZone1, XZone2, YZone2)) :-
    XZone1 #= X - 1,
    XZone2 #= X + 1,
    YZone1 #= Y - 1,
    YZone2 #= Y + 1.

% positional operators that modify the cursor
% should go in position.pl
% search around the right/left/top/bottom end of a seg
rightOfSeg(seg(h, _, _, CoorFin), CurIn, CurOut) :-
    CurIn = cursor(_, _, CurEl, _),
    CoorFin = coorFin(X, Y),
    CoorRight = coor(X, Y),
    zoneAroundCoor(CoorRight, Zone),
    CurOut = cursor(X, Y, CurEl, Zone).

leftOfSeg(seg(h, _, CoorDeb, _), CurIn, CurOut) :-
    CurIn = cursor(_, _, CurEl, _),
    CoorDeb = coorDeb(X, Y),
    CoorLeft = coor(X, Y),
    zoneAroundCoor(CoorLeft, Zone),
    CurOut = cursor(X, Y, CurEl, Zone).

topOfSeg(seg(v, _, CoorDeb, _), CurIn, CurOut) :-
    CurIn = cursor(_, _, CurEl, _),
    CoorDeb = coorDeb(X, Y),
    CoorTop = coor(X, Y),
    zoneAroundCoor(CoorTop, Zone),
    CurOut = cursor(X, Y, CurEl, Zone).

bottomOfSeg(seg(v, _, _, CoorFin), CurIn, CurOut) :-
    CurIn = cursor(_, _, CurEl, _),
    CoorFin = coorFin(X, Y),
    CoorBottom = coor(X, Y),
    zoneAroundCoor(CoorBottom, Zone),
    CurOut = cursor(X, Y, CurEl, Zone).
