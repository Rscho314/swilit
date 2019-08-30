:- module(app_swilit, []).
:- use_module(library(pengines)).

:- pengine_application(swilit).
:- use_module(swilit:parse).

:- use_module(pengine_sandbox:parse).
:- use_module(library(sandbox)).

:- multifile sandbox:safe_primitive/1.

sandbox:safe_primitive(parse:parse_query(_, _)).
sandbox:safe_primitive(parse:tree_atomic_terms(_, _)).

