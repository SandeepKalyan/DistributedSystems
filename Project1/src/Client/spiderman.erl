-module(spiderman).

-export([myprogram/0]).

createWeb()->
  net_kernel:start([list_to_atom("spidey@sandy")]),
  erlang:set_cookie(erlang:node(),spiderman),
  NodeGenerated = erlang:node(),
  NodesGeneratedList = atom_to_list(NodeGenerated),
  if
    "spidey@sandy" == NodesGeneratedList ->
      io:fwrite("Spidey Node Created\n");
    true ->
      io:fwrite("Spidey Node Creation Failed")
  end,
  net_kernel:connect_node(list_to_atom("madame@sandy.")),
  [A | _B] = nodes(),
  if
    A == 'madame@sandy.' ->
      io:fwrite("Client - Server Connected Established Successfully\n");
    true ->
      io:fwrite("Worker - Server Connection Failed")
  end,
  node().

contact_madame()->
  {madameweb,'madame@sandy.'}! {hello,from,self()}.

receive_printing_actor_id() ->
  receive
    printingActor ->
      io:fwrite("Received Actor Printing ID from the server.")
  end.

spawn_server_actor_mining(_,0)->
  io:fwrite("Client actors who mine are successfully spawned and started mining.");
spawn_server_actor_mining(_NumberOfZeros,NumberOfActors)->
  PID=spawn(spideymining,mine,[_NumberOfZeros]),
  PID!something,
  io:fwrite("Thread spawned to mine for leading zeros: ~p~n",[_NumberOfZeros]),
  spawn_server_actor_mining(_NumberOfZeros,NumberOfActors-1).

venom_kill()->
  receive
    kill ->
      ok
  end.

myprogram() ->
  createWeb(),
  register(spiderman,self()),
  contact_madame(),
  ActorPrintingID = receive_printing_actor_id(),
  io:fwrite("~p~n",[ActorPrintingID]),
  spawn_server_actor_mining(4,30),
  venom_kill().