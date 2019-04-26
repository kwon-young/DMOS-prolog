:- module(dmos, [segDansCur/2]).

:- use_module(library(clpfd)).

% check if either end point of a seg is in the cursor zone
% should go dmos.pl
segDansCur(seg(coor(XSeg1, YSeg1), _CoorFin),
           cursor(_, zone(coor(X1, Y1), coor(X2, Y2)))) :-
        XSeg1 #>=X1,
        XSeg1 #=< X2,
        YSeg1 #>=Y1,
        YSeg1 #=< Y2.
segDansCur(seg(_CoorDeb, coor(XSeg2, YSeg2)),
           cursor(_, zone(coor(X1, Y1), coor(X2, Y2)))) :-
        XSeg2 #>=X1,
        XSeg2 #=< X2,
        YSeg2 #>=Y1,
        YSeg2 #=< Y2.
