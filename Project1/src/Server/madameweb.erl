-module(madameweb).

-export([start_server/1,spawn_server_actor_printing/0,spawn_server_actor_mining/2]).

createWeb(IP)->
  Str = string:concat("madame@",IP),
  net_kernel:start([list_to_atom(Str)]),
  erlang:set_cookie(erlang:node(),spiderman),
  NodeGenerated = erlang:node(),
  NodesGeneratedList = atom_to_list(NodeGenerated),
  if
    "madame@sandy." == NodesGeneratedList ->
      io:fwrite("Master Node Created\n");
    true ->
      io:fwrite("Master Node Creation Failed")
  end,
  node().

spawn_server_actor_printing()->
  register(printingActor,spawn(printing,print,[])).

spawn_server_actor_mining(_,0)->
  io:fwrite("Server actors who mine are successfully spawned and started mining.");
spawn_server_actor_mining(_NumberOfZeros,NumberOfActors)->
  spawn(mining,mine,[_NumberOfZeros]),
  io:fwrite("~p~n",[_NumberOfZeros]),
  spawn_server_actor_mining(_NumberOfZeros,NumberOfActors-1).

receive_clients() ->
  receive
    {hello,from,ClientPID} ->
      ClientPID ! printingActor;
    print ->
      io:fwrite("received")
  end,
  receive_clients().

start_server(IP) ->
  register(madameweb,self()),
  NodeName=createWeb(IP),
  io:fwrite(NodeName),
  PrintingCheck = spawn_server_actor_printing(),
  io:fwrite("~nPrinting actor spawn check: ~p~n",[PrintingCheck]),
  spawn_server_actor_mining(4,5),
  io:fwrite("~p~n",[self()]),
  receive_clients().









