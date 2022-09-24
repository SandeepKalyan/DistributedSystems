-module(printing).

-export([print/0]).

print()->
  receive
    print->
      io:fwrite("mined~n");
    printspidey ->
      io:fwrite("spidey~n")
  end,
  print().