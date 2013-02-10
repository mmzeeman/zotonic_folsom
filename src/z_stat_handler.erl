%%

-module(z_stat_handler).

-export([init/0, update/2]).

-include_lib("zotonic.hrl").


%%
%% Initialize folsom.
%% 
init() ->
    ok
   
% @doc
% 
update(#counter{name=Name, op='incr', value=V}, #stats_from{host=Host, system=System}) ->
	folsom_metrics:notify({Host, System, Name}, {inc, V});
update(#counter{name=Name, op='decr', value=V}, #stats_from{host=Host, system=System}) ->
    folsom_metrics:notify({Host, System, Name}, {dec, V});
update(#counter{name=Name, op='set', value=V}, #stats_from{host=Host, system=System}) ->
    ok;
update(#histogram{name=Name, value=Value}, #stats_from{host=Host, system=System}) ->
    folsom_metrics:notify({{Host, System, Name}, Value}).
    
update(_Stat, []) ->
    ok;
update(Stat, [H|T]) ->
    update(Stat, H),
    update(Stat, T).
    
