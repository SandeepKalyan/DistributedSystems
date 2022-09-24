-module(mining).

-export([mine/1]).

mine(N)->
  receive
    something ->
      io:fwrite("received~n"),
      {printingActor,'madameweb@sandy.'} ! print_spidey
  end,
  mine(N).