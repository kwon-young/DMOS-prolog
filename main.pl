:- use_module(carre).

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

% main entry point of the program
% construct the initial cursor
% construct the input list of segment
% run the grammar carre
% should be in main.pl
eval_carre(SegCarre, CurOut, RemainingSeg):-
        listZone([0, 0, 100, 100], Zone),
        listlistSeg([[1, 1, 10, 1], [10, 1, 10, 10], [10, 10, 1, 10], [1, 10, 1, 1]], ListSeg),
        phrase(carre(SegCarre, cursor(coor(0, 0), Zone), CurOut), ListSeg, RemainingSeg).
