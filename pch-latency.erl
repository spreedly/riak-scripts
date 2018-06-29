(fun() ->

MMod = "postcommit_hook",
MFun = "send_to_kafka_riak_commitlog",

Pf = fun({call,
        {{Mod,Fun,
             [{r_object,
                  B,
                  K,
                  _,
                  _,
                  _,
                  _}]},
         _},
        Pid,
        {SH,SM,SS,SMS}}) ->
	io:format("CALL,~p,~p:~p:~p.~p,~p,~p~n",[Pid,SH,SM,SS,SMS,B,K]) ;

    ({retn,{{Mod,Fun,_},Ret},
          Pid,
          {RH,RM,RS,RMS}}) ->

	io:format("RET,~p,~p:~p:~p.~p~n",[Pid,RH,RM,RS,RMS]) ;

(X) ->
	io:format("MISS~p~n",[X])
end,

redbug:start(MMod ++ ":" ++ MFun  ++   "->return,stack",
	[{time, 10000 },
	{msgs,100},
	{print_fun,Pf}])
end)().
