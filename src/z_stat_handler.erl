%%

-module(z_stat_handler).

-export([init/0, update/2]).

-include_lib("zotonic.hrl").


%%
%% Initialize folsom.
%% 
init() ->
	folsom:start().
    
% counter
update(#counter{name=Name, op=incr, value=Value}, #stats_from{host=Host, system=System}) ->
	folsom_metrics:notify({Host, System, Name}, {inc, Value});
update(#counter{name=Name, op=decr, value=Value}, #stats_from{host=Host, system=System}) ->
    folsom_metrics:notify({Host, System, Name}, {dec, Value});
update(#counter{name=Name, op=clear, value=Value}, #stats_from{host=Host, system=System}) ->
    folsom_metrics:notify({Host, System, Name}, clear);

% histogram
update(#histogram{name=Name, value=Value}, #stats_from{host=Host, system=System}) ->
    folsom_metrics:notify({{Host, System, Name}, Value}).
  
    
