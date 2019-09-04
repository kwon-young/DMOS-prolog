:- module(test_utils, [cc1/1, seg1/1, seg2/1, seg3/1, seg4/1, seg11/2,
                       cursor1/2, cursor2/2, cursor3/2, cursor4/2,
                       cons_structure1/1, cons_structure2/1]).

cc1(ccx([], coorDeb(0, 0), coorFin(10, 10))).

seg1(seg(h, [], coorDeb(0, 0), coorFin(10, 0))).
seg2(seg(h, [], coorDeb(0, 10), coorFin(10, 10))).
seg3(seg(v, [], coorDeb(0, 0), coorFin(0, 10))).
seg4(seg(v, [], coorDeb(10, 0), coorFin(10, 10))).

seg11(Etiquette, Seg) :-
    seg1(seg(Dir, List_Etiq, CoorDeb, CoorFin)),
    Seg = seg(Dir, [Etiquette | List_Etiq], CoorDeb, CoorFin).

cursor1(CC, cursor(0, 0, CC, zone(0, 0, 0, 0))).
cursor2(CC, cursor(0, 0, CC, zone(0, 0, 100, 100))).
cursor3(CC, cursor(10, 0, CC, zone(9, -1, 11, 1))).
cursor4(CC, cursor(0, 0, CC, zone(-1, -1, 1, 1))).

cons_structure1(Struct) :-
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
    EnsResolDispo = [Resol].

cons_structure2(Struct2) :-
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
    List_SegH2 = [Seg2],
    Struct2 = structDMOS(StructImageResol, List_CC, List_SegH2, List_SegV).
