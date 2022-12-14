-module(madameweb).

-export([start_server/0,spawn_server_actor_printing/0,spawn_server_actor_mining/2]).

createWeb()->

  net_kernel:start([list_to_atom("madame@sandy.")]),
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
  io:fwrite("Thread spawned to mine for leading zeros: ~p~n",[_NumberOfZeros]),
  spawn_server_actor_mining(_NumberOfZeros,NumberOfActors-1).

receive_clients() ->
  receive
    {hello,from,ClientPID} ->
      ClientPID ! printingActor;
    print ->
      io:fwrite("received")
  end,
  receive_clients().

write_to_log(StartWallTime,StartRunTime,EndWallTime,EndRunTime,CpuUtilRatio) ->
  {ok, S} = file:open("PerformanceOutput.txt", [write]),
  io:format(S, "This File Contains necessary Information about the CPU time reporting and the CPU Utilization Co-efficient.~n", []),
  io:format(S, "**********************************************************************************************************.~n", []),
  io:format(S, "Start Wall Time : ~p~n", [StartWallTime]),
  io:format(S, "Start Run Time : ~p~n", [StartRunTime]),
  io:format(S, "End Wall Time : ~p~n", [EndWallTime]),
  io:format(S, "End Run Time : ~p~n", [EndRunTime]),
  io:format(S, "CPU Utilization Ratio : ~p~n", [CpuUtilRatio]).

start_server() ->
  StartWallTime=element(1,statistics(wall_clock)),
  StartRunTime=element(1,statistics(runtime)),
  register(madameweb,self()),
  NodeName=createWeb(),
  io:fwrite(NodeName),
  PrintingCheck = spawn_server_actor_printing(),
  io:fwrite("~nPrinting actor spawn check: ~p~n",[PrintingCheck]),
  spawn_server_actor_mining(4,30),
  io:fwrite("~p~n",[self()]),
  timer:sleep(20000),
  EndWallTime = element(1,statistics(wall_clock)),
  EndRunTime =element(1,statistics(runtime)),
  CpuUtilRatio = (EndRunTime-StartRunTime) / (EndWallTime-StartWallTime),
  write_to_log(StartWallTime,StartRunTime,EndWallTime,EndRunTime,CpuUtilRatio),
  receive_clients().









