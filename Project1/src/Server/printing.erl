-module(printing).

-export([print/0]).

print()->
  receive
    {coin,Str}->
      io:fwrite("~p~n",[Str]);
    printspidey ->
      io:fwrite("spidey~n")
  end,
  print().