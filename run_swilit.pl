%load file for swilit

:- use_module(library(pengines)).
:- use_module(library(http/http_error)).
:- use_module(server).
:- use_module(storage).

:- use_module(lib/admin/admin).
:- use_module(lib/admin/server_statistics).
:- use_module(lib/admin/change_passwd).

:- if(exists_source(apps(swilit/app))).
:- use_module(apps(swilit/app)).
:- endif.

:- server(3030).
