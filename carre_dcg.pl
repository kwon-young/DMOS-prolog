:- module(carre, [carre//3]).

:- use_module(position).
:- use_module(cond).
:- use_module(epf_dcg).

% this grammar rule describe how a square should look like
% should be in carre.pl
%        Seg1
%       ------
%      |      |
% Seg4 |      | Seg2
%      |      |
%       ------
%        Seg3
carre([Seg1, Seg2, Seg3, Seg4], CurIn, CurOut) -->
        term_seg(noCond, Seg1, CurIn, Cur1),
        at(rightOfSeg, Seg1, Cur1, Cur2),
        term_seg(noCond, Seg2, Cur2, Cur3),
        at(bottomOfSeg, Seg2, Cur3, Cur4),
        term_seg(noCond, Seg3, Cur4, Cur5),
        at(leftOfSeg, Seg3, Cur5, Cur6),
        term_seg(noCond, Seg4, Cur6, CurOut).
