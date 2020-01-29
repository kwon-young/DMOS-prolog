:- module(cond, [noCond/1, condSegH/1, condSegV/1]).

/** <module> Conditions Module
 *
 * Helper predicates for terminal consumption conditions.
 * These predicates are used together with the term_seg or term_cc EPF
 * operator to specify conditions that an element should fullfill to be
 * consumed.
 *
 * By convention, all condition predicates start with a 'cond'.
 * These predicates always take at least a single parameter which is the
 * current element considered.
 *
 * @author Kwon-Young Choi
 * @version 0.1
 */

%% noCond(+El) is det
%
% The noCond/1 predicate always succeed regardless of El.
%
% * noCond(El)
%   (`true.`)
%
% @param El Unused element.
noCond(_El).

%% condSegH(+Seg:seg) is semidet.
%
% Assert that input segment is horizontal.
%
% * condSegH(seg(h, _, _, _))
%   (`true.`)
%
% * condSegH(seg(v, _, _, _))
%   (`false.`)
%
% @param Seg Input segment.
condSegH(seg(h, _, _, _)).

%% condSegV(+Seg:seg) is semidet.
%
% Assert that input segment is vertical.
%
% * condSegV(seg(h, _, _, _))
%   (`false.`)
%
% * condSegV(seg(v, _, _, _))
%   (`true.`)
%
% @param Seg Input segment.
condSegV(seg(v, _, _, _)).
