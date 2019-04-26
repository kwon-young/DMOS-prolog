:- module(epf, [at//3, at//4, term_seg//4]).

:- use_module(dmos).

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
