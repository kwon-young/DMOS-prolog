:- begin_tests(cond).
:- use_module(cond).
:- use_module(test_utils).

test(noCond) :-
    seg1(Seg),
    noCond(Seg).

test(condSegH) :-
    seg1(Seg),
    condSegH(Seg).

test(condSegH, [fail]) :-
    seg3(Seg),
    condSegH(Seg).

test(condSegV) :-
    seg4(Seg),
    condSegV(Seg).

test(condSegV, [fail]) :-
    seg2(Seg),
    condSegV(Seg).

:- end_tests(cond).
