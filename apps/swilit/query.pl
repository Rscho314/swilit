:- module(query, [query_entrez/9]).

:- use_module(library(http/http_open)).
:- use_module(library(http/http_ssl_plugin)).
:- use_module(library(http/json)).

% most general query, must be specialized
query_entrez(Util,
             Db,
             Term,
             Retstart, Retmax, Rettype, Mindate, Maxdate,
             Out):-
    string_concat('/entrez/eutils/', Util, P),
    string_concat(P,'.fcgi', Path),
    http_open([host('eutils.ncbi.nlm.nih.gov'),
               path(Path),
               search([db=Db,
                       term=Term,
                       retstart=Retstart,
                       retmax=Retmax,
                       rettype=Rettype,
                       retmode=json, %json is shorter&better
                       mindate=Mindate,
                       maxdate=Maxdate
                      ])
              ],
              In,
              []),
    json_read_dict(In, Out),
    close(In).
















