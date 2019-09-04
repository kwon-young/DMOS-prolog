:- begin_tests(position).
:- use_module(position).
:- use_module(test_utils).

test(pageEntiere) :-
    cc1(CC),
    cursor1(CC, CursorIn),
    cursor2(CC, CursorOut),
    pageEntiere(CursorIn, CursorOut).

test(rightOfSeg) :-
    seg1(Seg),
    cc1(CC),
    cursor1(CC, CursorIn),
    cursor3(CC, CursorOut),
    rightOfSeg(Seg, CursorIn, CursorOut).

test(leftOfSeg) :-
    seg2(Seg),
    cc1(CC),
    cursor1(CC, CursorIn),
    CursorOut = cursor(0, 10, CC, zone(-1, 9, 1, 11)),
    leftOfSeg(Seg, CursorIn, CursorOut).

test(topOfSeg) :-
    seg3(Seg),
    cc1(CC),
    cursor1(CC, CursorIn),
    CursorOut = cursor(0, 0, CC, zone(-1, -1, 1, 1)),
    topOfSeg(Seg, CursorIn, CursorOut).

test(bottomOfSeg) :-
    seg4(Seg),
    cc1(CC),
    cursor1(CC, CursorIn),
    CursorOut = cursor(10, 10, CC, zone(9, 9, 11, 11)),
    bottomOfSeg(Seg, CursorIn, CursorOut).

:- end_tests(position).
