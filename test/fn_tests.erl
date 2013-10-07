%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(fn_tests).

-include_lib("eunit/include/eunit.hrl").


%% API tests.

b_test_() ->
  [
   ?_test(basic_b_abs())
   %% TODO ?_test(b_abs_w_two_formal_params()),
   %% TODO ?_test(nested_b_abs_shadow_formal_params_correctly()),
   %% TODO ?_test(b_abs_nested_in_wheredim_does_not_cause_wrong_substitution()),
   %% TODO ?_test(wheredim_nested_in_b_abs_does_not_cause_wrong_substitution()),
   %% TODO ?_test(basic_b_apply())
  ].

basic_b_abs() ->
  %% TODO: parser for sequence of abstractions and applications
  {ok, [FnT]} = tea:string("fun F.argAsVarId = argAsVarId"),
  ?assertEqual({fn, "F", [{b_param,"argAsVarId"}], "argAsVarId"},
               FnT),
  {wherevar, "F", [{"F", BAbsT0}]} = t0(FnT), %% XXX This wherevar in transform1 smells badly
  ?assertEqual({b_abs, [], ["argAsVarId"], "argAsVarId"},
               BAbsT0),
  ArgAsPhiDim = {phi,"argAsVarId"},
  ?assertEqual({b_abs, [], [ArgAsPhiDim], {'#',ArgAsPhiDim}},
               t1(BAbsT0)),
  %% TODO: eval
  ok.

%% Internals

t0(T) ->
  ttransform0:transform0(T).

t1(T) ->
  ttransform1:transform1(T).

%% End of Module.
