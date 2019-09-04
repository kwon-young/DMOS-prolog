:- begin_tests(epf).
:- use_module(epf).
:- use_module(position).
:- use_module(cond).
:- use_module(test_utils).

test(at_abs) :-
    Goal = pageEntiere,
    cc1(CC),
    cursor1(CC, CursorIn),
    cons_structure1(StructIn),
    StructOut = StructIn,
    cursor2(CC, CursorOut),
    at_abs(Goal, StructIn, StructOut, CursorIn, CursorOut).

test(at) :-
    Goal = rightOfSeg,
    cc1(CC),
    cursor1(CC, CursorIn),
    cons_structure1(StructIn),
    StructOut = StructIn,
    cursor3(CC, CursorOut),
    seg1(Seg),
    at(Goal, Seg, StructIn, StructOut, CursorIn, CursorOut).

test(term_seg) :-
    PreCond = noCond,
    PostCond = noCond,
    Etiquette = test_etiq,
    seg1(Seg),
    Seg2 = seg(h, [Etiquette], coorDeb(0, 0), coorFin(10, 0)),
    cursor1(Seg, CursorIn),
    cons_structure1(StructIn),
    cons_structure2(StructOut),
    cursor1(noCC, CursorOut),
    term_seg(PreCond, PostCond, Etiquette, Seg2, StructIn, StructOut,
        CursorIn, CursorOut).

test(term_seg) :-
    PreCond = noCond,
    PostCond = noCond,
    Etiquette = test_etiq,
    seg11(Etiquette, Seg),
    cursor4(noCC, CursorIn),
    cons_structure1(StructIn),
    cons_structure2(StructOut),
    cursor1(noCC, CursorOut),
    term_seg(PreCond, PostCond, Etiquette, Seg, StructIn, StructOut,
        CursorIn, CursorOut).

:- end_tests(epf).
