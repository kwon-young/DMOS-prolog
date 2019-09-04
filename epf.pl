:- module(epf, [at_abs/5, at/6, term_seg/8]).
:- meta_predicate at_abs(2, +, -, +, -).
:- meta_predicate at(3, ?, +, -, +, -).
:- meta_predicate term_seg(1, 1, ?, -, +, -, +, -).

:- use_module(library(clpfd)).
:- use_module(library(edcg)).
:- use_module(dmos).

:- multifile edcg:pred_info/3.

% this essentially adds 4 arguments to all grammar clauses
edcg:acc_info(structure, X, _In, X, true).
edcg:acc_info(cursor, X, _In, X, true).

edcg:pred_info(at_abs, 1, [structure, cursor]).
edcg:pred_info(at, 2, [structure, cursor]).
edcg:pred_info(term_seg, 4, [structure, cursor]).

% the at meta predicate is a EPF operator that modify the cursor using the Goal
% positional operator predicate
at_abs(Goal) -->>
    CurIn/cursor,
    {call(Goal, CurIn, CurOut)},
    [CurOut]:cursor.
at(Goal, Arg) -->>
    CurIn/cursor,
    {call(Goal, Arg, CurIn, CurOut)},
    [CurOut]:cursor.

% the term_seg meta predicate is a EPF operator that modify the list of seg.
% this predicate first filters out all components outside the cursor,
% The predicate fails if the first component inside a cursor fails the Cond predicate
% it only consume a seg if the Cond predicate succeed.
%
term_seg(PreCond, PostCond, Etiquette, SegOut) -->>
    CurIn/cursor,
    StructIn/structure,
    {term_seg_pl(PreCond, PostCond, Etiquette, SegOut, CurIn, CurOut, StructIn, StructOut)},
    [CurOut]:cursor,
    [StructOut]:structure.

% if zone is not defined, consume current element in cursor
term_seg_pl(PreCond, PostCond, Etiquette, SegOut, CurIn, CurOut, StructIn, StructOut) :-
    CurIn = cursor(_, _, SegIn, zone(0, 0, 0, 0)),
    !, % zone is not defined, use current element
    call(PreCond, SegIn),
    call(PostCond, SegIn),
    structure_delete_seg(StructIn, SegIn, StructOut),
    SegIn = seg(Dir, List_Etiquette, CoorDeb, CoorFin),
    SegOut = seg(Dir, [Etiquette | List_Etiquette], CoorDeb, CoorFin),
    CurOut = cursor(0, 0, noCC, zone(0, 0, 0, 0)).
% zone is defined, search in the structure
term_seg_pl(PreCond, PostCond, Etiquette, SegOut, CurIn, CurOut, StructIn, StructOut) :-
    CurIn = cursor(XIn, YIn, CurEl, Zone),
    list_seg_in_zone(Zone, StructIn, List_Seg1),
    include(PreCond, List_Seg1, List_Seg2),
    predsort(anchor_sort(XIn, YIn), List_Seg2, [SegIn | _]),
    call(PostCond, SegIn),
    structure_delete_seg(StructIn, SegIn, StructOut),
    SegIn = seg(Dir, List_Etiquette, CoorDeb, CoorFin),
    SegOut = seg(Dir, [Etiquette | List_Etiquette], CoorDeb, CoorFin),
    CoorDeb = coorDeb(XOut, YOut),
    CurOut = cursor(XOut, YOut, CurEl, zone(0, 0, 0, 0)).
