%%%-------------------------------------------------------------------
%%% @author vvsvs
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. Sep 2022 1:21 PM
%%%-------------------------------------------------------------------
-module('helloworld').

-author("vvsvs").

-import(io,[fwrite/2]).
-import(io,[fwrite/1]).
-import(io_lib,[format/2]).
-import(binary,[decode_unsigned/1]).
-import(crypto,[hash/2]).
-import(string,[equal/2]).

-export([start/0]).

func(X)  ->
  Bool = string:equal(string:substr(X,1,4),"0000"),

  if
    Bool ->
      fwrite("~p~n",[X]);
    true->
      fwrite("")
  end,
  func(format("~64.16.0b",[decode_unsigned(hash(sha256,X))])).

start() ->
  func(format("~64.16.0b",[decode_unsigned(hash(sha256,"ssunkara;kjsdfk11"))])).


