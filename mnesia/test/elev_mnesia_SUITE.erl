-module(elev_mnesia_SUITE).
-include_lib("common_test/include/ct.hrl").
-export([init_per_suite/1, end_per_suite/1,
         init_per_testcase/2, end_per_testcase/2, all/0]).
-export([add_elevator/1, add_order/1]).

all() -> [add_elevator, add_order].

init_per_suite(Config) ->
    Priv = ?config(priv_dir, Config),
    application:load(mnesia),
    application:set_env(mnesia, dir, Priv),
    application:load(elev_mnesia),
    elev_mnesia:install([node()]),
    application:start(mnesia),
    application:start(elev_mnesia),
    Config.

end_per_suite(_Config) ->
    application:stop(mnesia),
    ok.

init_per_testcase(add_elevator, Config) ->
	Config;
init_per_testcase(add_order, Config) ->
	Config.

end_per_testcase(_, _Config) ->
    ok.

add_elevator(_Config) ->
    ok = elev_mnesia:add_elevator(1, 1, 1, 1).

add_order(_Config) ->
    ok = elev_mnesia:add_order(1, 1, 1).

