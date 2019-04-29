:- module(carre, [carre/5]).

:- use_module(library(edcg)).
:- use_module(position).
:- use_module(cond).
:- use_module(epf_edcg).

edcg:pred_info(carre, 1, [cursor, dcg]).

% this grammar rule describe how a square should look like
% should be in carre.pl
%        Seg1
%       ------
%      |      |
% Seg4 |      | Seg2
%      |      |
%       ------
%        Seg3
carre([Seg1, Seg2, Seg3, Seg4]) -->>
        term_seg(noCond, Seg1),
        at(rightOfSeg, Seg1),
        term_seg(noCond, Seg2),
        at(bottomOfSeg, Seg2),
        term_seg(noCond, Seg3),
        at(leftOfSeg, Seg3),
        term_seg(noCond, Seg4).
