-module(mining).

-import(io,[format/1,fwrite/1,fwrite/2,fread/2]).
-import(io_lib,[format/2]).
-import(binary,[decode_unsigned/1]).
-import(crypto,[hash/2,strong_rand_bytes/1]).
-import(string,[right/3,to_integer/1,equal/2,concat/2]).

-export([mine/1]).

mine(N)->
 % printingActor ! printspidey,
  RandomString=format("~b", [decode_unsigned(strong_rand_bytes(8))]),
  Id=concat("ssunkara;",RandomString),
  Coin=format("~64.16.0b", [decode_unsigned(hash(sha256, Id))]),
  Bool=string:equal(string:substr(Coin,1,N),right(integer_to_list(0), N, $0)),
  if Bool ->
    Str = concat(concat(Id,"  "),Coin),
    printingActor ! {coin,Str};
    true ->
      ok
  end,
  mine(N).