:- module(epf, [at/5, at/6, term_seg/6]).

:- use_module(library(edcg)).
:- use_module(dmos).

% EPF grammar operator
% should go in epf.pl
edcg:acc_info(cursor, X, _In, X, true).
edcg:pred_info(at, 1, [cursor, dcg]).
edcg:pred_info(at, 2, [cursor, dcg]).
edcg:pred_info(term_seg, 2, [cursor, dcg]).

% the at meta predicate is a EPF operator that modify the cursor using the Goal
% positional operator predicate
at(Goal) -->>
        CurIn/cursor,
        {call(Goal, CurIn, CurOut)},
        [CurOut]:cursor.
at(Goal, Arg) -->>
        CurIn/cursor,
        {call(Goal, Arg, CurIn, CurOut)},
        [CurOut]:cursor.

% the term_seg meta predicate is a EPF operator that modify the list of seg.
% it consume a seg if the seg is in the cursor zone and if the Cond predicate
% succeed.
term_seg(Cond, Seg) -->>
        [Seg],
        Cur/cursor,
        { segDansCur(Seg, Cur),
        call(Cond, Seg)}.
term_seg(Cond, Seg) -->>
        [_],
        term_seg(Cond, Seg).
