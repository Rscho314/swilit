:- use_module(library(pengines)).

enumerate(X) :- pengine_property(X, self(X)).
is_remote(X) :- pengine_property(X, remote(X)).
pull_response(X) :- pengine_property(X, self(X)),
    pengine_pull_response(X,_).

