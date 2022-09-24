-module('demo').

-export([start_pong/0,start_ping/1, pong/0, ping/2]).

ping(0,Pong_PID) ->
  Pong_PID ! finished,
  io:fwrite("~p~n",["ping finished"]);

ping(N,Pong_PID) ->
  Pong_PID ! {not_yet,self()},
  receive
    got->
      io:fwrite("~p~n",["pinged"])
  end,
  ping(N-1,Pong_PID).

pong()->
  receive
    finished ->
      io:fwrite("~p~n",["pong finished"]);
    {not_yet,Ping_PID} ->
      io:fwrite("~p~n",["ponged"]),
      Ping_PID ! got,
      pong()
  end.

start_pong() ->
  register(pong, spawn(tut17, pong, [])).

start_ping(Pong_Node) ->
  spawn(tut17, ping, [3, Pong_Node]).

