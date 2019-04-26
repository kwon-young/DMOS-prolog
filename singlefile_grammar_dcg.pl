:- use_module(library(clpfd)).
:- use_module(position).
:- use_module(cond).
:- use_module(dmos).

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

% EPF grammar operator
% should go in epf.pl
% the at meta predicate is a EPF operator that modify the cursor using the Goal
% positional operator predicate
at(Goal, CurIn, CurOut) -->
        {call(Goal, CurIn, CurOut)}.
at(Goal, Arg, CurIn, CurOut) -->
        {call(Goal, Arg, CurIn, CurOut)}.

% the term_seg meta predicate is a EPF operator that modify the list of seg.
% it consume a seg if the seg is in the cursor zone and if the Cond predicate
% succeed.
term_seg(Cond, Seg, Cur, _CurOut) -->
        [Seg],
        { segDansCur(Seg, Cur),
        call(Cond, Seg)}.
term_seg(Cond, Seg, CurIn, CurOut) -->
        [_],
        term_seg(Cond, Seg, CurIn, CurOut).

% this grammar rule describe how a square should look like
% should be in carre.pl
%        Seg1
%       ------
%      |      |
% Seg4 |      | Seg2
%      |      |
%       ------
%        Seg3
carre([Seg1, Seg2, Seg3, Seg4], CurIn, CurOut) -->
        term_seg(noCond, Seg1, CurIn, Cur1),
        at(rightOfSeg, Seg1, Cur1, Cur2),
        term_seg(noCond, Seg2, Cur2, Cur3),
        at(bottomOfSeg, Seg2, Cur3, Cur4),
        term_seg(noCond, Seg3, Cur4, Cur5),
        at(leftOfSeg, Seg3, Cur5, Cur6),
        term_seg(noCond, Seg4, Cur6, CurOut).

% main entry point of the program
% construct the initial cursor
% construct the input list of segment
% run the grammar carre
% should be in main.pl
eval_carre(SegCarre, CurOut, RemainingSeg) :-
        listZone([0, 0, 100, 100], Zone),
        listlistSeg([[1, 1, 10, 1], [10, 1, 10, 10], [10, 10, 1, 10], [1, 10, 1, 1]], ListSeg),
        phrase(carre(SegCarre, cursor(coor(0, 0), Zone), CurOut), ListSeg, RemainingSeg).
