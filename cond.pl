:- module(cond, [noCond/1, condSegH/1, condSegV/1]).

%% noCond(+El) is det
%
% The noCond/1 predicate always succeed regardless of El.
%
% * noCond(seg(h, _, _, _))
%   (`true.`)
%
% * noCond(seg(v, _, _, _))
%   (`true.`)
%
% @param El Unused element.
noCond(_El).

%% condSegH(+Seg:seg) is semidet.
%
% Assert that input segment is horizontal.
%
% @param Seg Input segment.
condSegH(seg(h, _, _, _)).

%% condSegV(+Seg:seg) is semidet.
%
% Assert that input segment is vertical.
%
% @param Seg Input segment.
condSegV(seg(v, _, _, _)).
