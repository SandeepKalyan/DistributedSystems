-module(spideymining).

-export([mine/1]).

mine(N)->
  receive
    something ->
      {printingActor,'madame@sandy.'} ! printspidey
  end,
  mine(N).