:- use_module(library(clpfd)).
:- use_module(library(edcg)).
:- use_module(position).

% utility function to construct seg from list
% should go in main.pl
listSeg([X1, Y1, X2, Y2], seg(coor(X1, Y1), coor(X2, Y2))).

% utility function to construct list of seg from list of list
% should go in main.pl
listlistSeg([], []).
listlistSeg([ListCoord | ListListCoord], [ListSeg | ListListSeg]) :-
        listSeg(ListCoord, ListSeg),
        listlistSeg(ListListCoord, ListListSeg).

% utility function to construct zone from list
% should go in main.pl
listZone([X1, Y1, X2, Y2], zone(coor(X1, Y1), coor(X2, Y2))).


%% utility functions for positional operator
%% should go in position.pl
%% get right/left/top/bottom most coordinate
%rightCoor(coor(X1, Y1), coor(X2, _Y2), coor(X1, Y1)) :-
        %X1 #> X2.
%rightCoor(coor(X1, _Y1), coor(X2, Y2), coor(X2, Y2)) :-
        %X2 #> X1.

%leftCoor(coor(X1, Y1), coor(X2, _Y2), coor(X1, Y1)) :-
        %X1 #< X2.
%leftCoor(coor(X1, _Y1), coor(X2, Y2), coor(X2, Y2)) :-
        %X2 #< X1.

%topCoor(coor(X1, Y1), coor(_X2, Y2), coor(X1, Y1)) :-
        %Y1 #< Y2.
%topCoor(coor(_X1, Y1), coor(X2, Y2), coor(X2, Y2)) :-
        %Y2 #< Y1.

%bottomCoor(coor(X1, Y1), coor(_X2, Y2), coor(X1, Y1)) :-
        %Y1 #> Y2.
%bottomCoor(coor(_X1, Y1), coor(X2, Y2), coor(X2, Y2)) :-
        %Y2 #> Y1.

%% construct a little box zone centered on coor
%zoneAroundCoor(coor(X, Y), zone(coor(XZone1, YZone1), coor(XZone2, YZone2))) :-
        %XZone1 #= X - 1,
        %XZone2 #= X + 1,
        %YZone1 #= Y - 1,
        %YZone2 #= Y + 1.

%% positional operators that modify the cursor
%% should go in position.pl
%% search around the right/left/top/bottom end of a seg
%rightOfSeg(seg(CoorDeb, CoorFin), _, cursor(CoorRight, Zone)) :-
        %rightCoor(CoorDeb, CoorFin, CoorRight),
        %zoneAroundCoor(CoorRight, Zone).

%leftOfSeg(seg(CoorDeb, CoorFin), _, cursor(CoorLeft, Zone)) :-
        %leftCoor(CoorDeb, CoorFin, CoorLeft),
        %zoneAroundCoor(CoorLeft, Zone).

%topOfSeg(seg(CoorDeb, CoorFin), _, cursor(CoorTop, Zone)) :-
        %topCoor(CoorDeb, CoorFin, CoorTop),
        %zoneAroundCoor(CoorTop, Zone).

%bottomOfSeg(seg(CoorDeb, CoorFin), _, cursor(CoorBottom, Zone)) :-
        %bottomCoor(CoorDeb, CoorFin, CoorBottom),
        %zoneAroundCoor(CoorBottom, Zone).

% conditional operator
% should go in cond.pl
noCond(_).

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

% EPF grammar operator
% should go in epf.pl
edcg:acc_info(cursor, X, _In, X, true).
edcg:pred_info(at, 1, [cursor, dcg]).
edcg:pred_info(at, 2, [cursor, dcg]).
edcg:pred_info(term_seg, 2, [cursor, dcg]).
edcg:pred_info(carre, 1, [cursor, dcg]).

% the at meta predicate is a EPF operator that modify the cursor using the Goal
% positional operator predicate
at(Goal) -->>
        CurIn/cursor,
        {call(Goal, CurIn, CurOut)},
        [CurOut]:cursor.
at(Goal, Arg) -->>
        CurIn/cursor,
        {call(Goal, Arg, CurIn, CurOut)},
        [CurOut]:cursor.

% the term_seg meta predicate is a EPF operator that modify the list of seg.
% it consume a seg if the seg is in the cursor zone and if the Cond predicate
% succeed.
term_seg(Cond, Seg) -->>
        [Seg],
        Cur/cursor,
        { segDansCur(Seg, Cur),
        call(Cond, Seg)}.
term_seg(Cond, Seg) -->>
        [_],
        term_seg(Cond, Seg).

% this grammar rule describe how a square should look like
% should be in carre.pl
%        Seg1
%       ------
%      |      |
% Seg4 |      | Seg2
%      |      |
%       ------
%        Seg3
carre([Seg1, Seg2, Seg3, Seg4]) -->>
        term_seg(noCond, Seg1),
        at(rightOfSeg, Seg1),
        term_seg(noCond, Seg2),
        at(bottomOfSeg, Seg2),
        term_seg(noCond, Seg3),
        at(leftOfSeg, Seg3),
        term_seg(noCond, Seg4).

% main entry point of the program
% construct the initial cursor
% construct the input list of segment
% run the grammar carre
% should be in main.pl
eval_carre(SegCarre, CurOut, RemainingSeg):-
        listZone([0, 0, 100, 100], Zone),
        listlistSeg([[1, 1, 10, 1], [10, 1, 10, 10], [10, 10, 1, 10], [1, 10, 1, 1]], ListSeg),
        phrase(carre(SegCarre, cursor(coor(0, 0), Zone), CurOut), ListSeg, RemainingSeg).
