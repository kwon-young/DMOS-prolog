:- begin_tests(dmos).
:- use_module(dmos).
:- use_module(test_utils).

cons_structure3(Struct2) :-
    cc1(CC),
    List_CC = [CC],
    seg1(Seg1),
    seg2(Seg2),
    seg3(Seg3),
    seg4(Seg4),
    List_SegH = [Seg1, Seg2],
    List_SegV = [Seg3, Seg4],
    StructImageResol = structImageResol("Normal", EnsResolDispo),
    Struct = structDMOS(StructImageResol, List_CC, List_SegH, List_SegV),
    cursor1(CC, Cursor),
    Resol = resolution("Normal", Struct, Cursor),
    EnsResolDispo = [Resol],
    List_SegV2 = [Seg4],
    Struct2 = structDMOS(StructImageResol, List_CC, List_SegH, List_SegV2).

test(structure_delete_seg) :-
    seg1(Seg),
    cons_structure1(StructIn),
    cons_structure2(StructOut2),
    structure_delete_seg(StructIn, Seg, StructOut),
    StructOut2 = StructOut.

test(structure_delete_seg) :-
    seg3(Seg),
    cons_structure1(StructIn),
    cons_structure3(StructOut),
    structure_delete_seg(StructIn, Seg, StructOut).

test(list_seg_in_zone) :-
    Zone = zone(-1, -1, 1, 1),
    cons_structure1(Struct),
    list_seg_in_zone(Zone, Struct, List_Seg),
    seg1(Seg1),
    seg3(Seg3),
    List_Seg = [Seg1, Seg3].

test(list_seg_in_zone) :-
    Zone = zone(9, 9, 11, 11),
    cons_structure1(Struct),
    list_seg_in_zone(Zone, Struct, List_Seg),
    seg2(Seg2),
    seg4(Seg4),
    List_Seg = [Seg2, Seg4].

test(anchor_sort) :-
    X = 0,
    Y = 0,
    seg1(Seg1),
    seg2(Seg2),
    anchor_sort(X, Y, Delta, Seg1, Seg2),
    Delta = (<).

test(anchor_sort) :-
    X = 0,
    Y = 0,
    seg1(Seg1),
    seg2(Seg2),
    anchor_sort(X, Y, Delta, Seg2, Seg1),
    Delta = (>).

test(anchor_sort) :-
    X = 0,
    Y = 0,
    seg1(Seg1),
    seg3(Seg3),
    anchor_sort(X, Y, Delta, Seg1, Seg3),
    Delta = (=).

:- end_tests(dmos).
