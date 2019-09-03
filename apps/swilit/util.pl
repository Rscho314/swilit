%this file contains all general utilties that do not fit elsewhere

:- module(util, [delayed_maplist/4]).

delayed_maplist(_, _, [], []):-!.
delayed_maplist(Seconds, Goal, [H1|T1], [H2|T2]):-
    call(Goal, H1, H2),
    sleep(Seconds),
    delayed_maplist(Seconds, Goal, T1, T2).
