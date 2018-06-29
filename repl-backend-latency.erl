(fun() ->
Pf = fun({call,
       {{riak_repl_util,do_repl_put,
            [{r_object,B,K,
                 [{r_content,
                      _,
                      Payload}],
                 _,
                 _,
                 _},
             B,true]},
        _},
       {Pid,{riak_repl_fullsync_worker,init,1}},
       {SH,SM,SS,SMS}}) ->
	io:format("CALL,~p,~p:~p:~p.~p,~p,~p~n",[Pid,SH,SM,SS,SMS,B,K]) ;

	({retn,{{riak_repl_util,do_repl_put,3},ok},
         {Pid,{riak_repl_fullsync_worker,init,1}},
         {RH,RM,RS,RMS}}
	) ->
	io:format("RET,~p,~p:~p:~p.~p~n",[Pid,RH,RM,RS,RMS]) ;

	(X) ->
	io:format("MISS~p~n",[X])

end,

redbug:start("riak_repl_util:do_repl_put({r_object, B, K, _ , _, _, _},B,true )->return,stack",
	[{time, 10000 },
	{msgs,100},
	{print_fun,Pf}])

end)().
