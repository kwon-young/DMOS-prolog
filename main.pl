:- use_module(carre).

% main entry point of the program
% construct the initial cursor
% construct the input list of segment
% run the grammar carre
% should be in main.pl
eval_carre(SegCarre, StructOut, CursorOut):-
    CC = ccx([], coorDeb(0, 0), coorFin(10, 10)),
    List_CC = [CC],
    List_SegH = [seg(h, [], coorDeb(0, 0), coorFin(10, 0)),
                 seg(h, [], coorDeb(0, 10), coorFin(10, 10))],
    List_SegV = [seg(v, [], coorDeb(0, 0), coorFin(0, 10)),
                 seg(v, [], coorDeb(10, 0), coorFin(10, 10))],
    StructImageResol = structImageResol("Normal", EnsResolDispo),
    Struct = structDMOS(StructImageResol, List_CC, List_SegH, List_SegV),
    Cursor = cursor(0, 0, courCC(CC), zone(0, 0, 0, 0)),
    Resol = resolution("Normal", Struct, Cursor),
    EnsResolDispo = [Resol],
    carre(SegCarre, Struct, StructOut, Cursor, CursorOut).
