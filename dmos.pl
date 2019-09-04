:- module(dmos, [structure_delete_seg/3, list_seg_in_zone/3,
                 anchor_sort/5]).

:- use_module(library(clpfd)).

% only delete Seg in the current structure
structure_delete_seg(StructIn, Seg, StructOut) :-
    Seg = seg(h, _, _, _),
    !,
    StructIn = structDMOS(StructImageResol, List_CC, List_SegHIn, List_SegV),
    StructOut = structDMOS(StructImageResol, List_CC, List_SegHOut, List_SegV),
    delete(List_SegHIn, Seg, List_SegHOut).
structure_delete_seg(StructIn, Seg, StructOut) :-
    Seg = seg(v, _, _, _),
    StructIn = structDMOS(StructImageResol, List_CC, List_SegH, List_SegVIn),
    StructOut = structDMOS(StructImageResol, List_CC, List_SegH, List_SegVOut),
    delete(List_SegVIn, Seg, List_SegVOut).

seg_in_zone(Zone, Seg) :-
    Zone = zone(ZX1, ZY1, ZX2, ZY2),
    Seg = seg(_, _, coorDeb(SX1, SY1), coorFin(SX2, SY2)),
    (
        SX2 >= ZX1,
        SY2 >= ZY1,
        SX2 =< ZX2,
        SY2 =< ZY2
    ;
        SX1 >= ZX1,
        SY1 >= ZY1,
        SX1 =< ZX2,
        SY1 =< ZY2
    ).

list_seg_in_zone(Zone, Struct, List_SegOut) :-
    Struct = structDMOS(_, _, List_SegHIn, _),
    include(seg_in_zone(Zone), List_SegHIn, List_SegHOut),
    Struct = structDMOS(_, _, _, List_SegVIn),
    include(seg_in_zone(Zone), List_SegVIn, List_SegVOut),
    append(List_SegHOut, List_SegVOut, List_SegOut).

euclide_distance(X1, Y1, X2, Y2, D) :-
    X #= X2 - X1,
    Y #= Y2 - Y1,
    D #= (X * X) + (Y * Y).

delta(D1, D2, =) :-
    D1 =:= D2, !.
delta(D1, D2, >) :-
    D1 > D2, !.
delta(D1, D2, <) :-
    D1 < D2.

anchor_sort(X, Y, Delta, Seg1, Seg2) :-
    Seg1 = seg(_, _, coorDeb(X1, Y1), _),
    Seg2 = seg(_, _, coorDeb(X2, Y2), _),
    euclide_distance(X, Y, X1, Y1, D1),
    euclide_distance(X, Y, X2, Y2, D2),
    delta(D1, D2, Delta).
