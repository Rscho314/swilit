:- begin_tests(parse).
:- use_module(parse).

%simple_term, atom, string
test(query_string):-
    S = "a",
    A =  a ,
    P = query(query_head(term(term_simple(a)))),
    assertion(parse_query(S, P)),
    assertion(parse_query(A, P)).

%general failure
test(query_string, [fail]):-
    parse_query("ab"
               ,
                query(query_head(term(term_simple(a))))).

:- end_tests(parse).




