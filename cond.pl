:- module(cond, [noCond/1, condSegH/1, condSegV/1]).

noCond(_).

condSegH(seg(h, _, _, _)).

condSegV(seg(v, _, _, _)).
