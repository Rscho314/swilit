:- module(parse, [print_query_tree/1,
                  parse_query/2,
                  tree_atomic_terms/2]).

:- use_module(tree_print).

%TODO:

% relational parser for the query (must be lowercase)
query(query(Qh)) --> query_head(Qh).
query(query(Qh, Qt)) --> query_head(Qh), query_tail(Qt).
query_head(query_head(T)) --> term(T).
query_head(query_head(S)) --> set(S).
query_tail(query_tail(St)) --> query_tail_set(St).
query_tail(query_tail(Wt)) --> query_tail_whitespace(Wt).
query_tail_set(query_tail_set(S)) --> set_operation(S).
query_tail_whitespace(query_tail_whitespace(Q)) --> whitespace, query(Q).
set(set(S)) --> [Pl], {char_type(Pl, paren(Pr)), Pl = '('}, query(S), [Pr].
set_operation(set_operation(Sop)) --> whitespace, set_operator(Sop).
set_operator(set_operator(Q)) --> and(Q) ; or(Q) ; not(Q).
and(and(Q)) --> [a,n,d], query_tail_whitespace(Q).
or(or(Q)) --> [o,r], query_tail_whitespace(Q).
not(not(Q)) --> [n,o,t], query_tail_whitespace(Q).
term(term(T)) --> term_simple(T).
term(term(T)) --> term_quoted(T).
term_simple(term_simple(C)) --> [C], {char_type(C, alnum)}, [].
term_simple(term_simple(C, S)) --> [C],{char_type(C, alnum)}, term_simple(S).
term_quoted(term_quoted(T)) --> [Qt],{char_type(Qt, quote)}, term_simple_sequence(T), [Qt].
term_simple_sequence(term_simple_sequence(T)) --> term_simple(T), [].
term_simple_sequence(term_simple_sequence(T, W, S)) --> term_simple(T), term_sequence_whitespace(W), term_simple_sequence(S).
term_sequence_whitespace(' ') --> [' '], [].
term_sequence_whitespace(' ') --> [' '], term_sequence_whitespace(_).
whitespace --> [' '],[].
whitespace --> [' '], whitespace.


parse_query(S, P) :-
    (   var(S), var(P)
    ->  query(P, C, []),
        string_chars(S, C)
    ;   (   var(S), nonvar(P)
        ->  query(P, C, []),
            string_chars(S, C) -> true ; false
        ;   string_chars(S, C),
            query(P, C, []) -> true ; false
        )
    ).

print_query_tree(S) :-
    parse_query(S, P),
    drucke_baum(P) -> true ; false.

% The following are not relational, cannot reconstruct original tree
% from leaves only, and named nodes make generation of candidate trees
% tedious (and probably useless anyway).
tree_leaves(T, L) :-
   phrase(leaves(T), L).

leaves(T) --> [T], {atom(T)}.
leaves(T) --> {T =.. [_, L, M, R]}, leaves(L), leaves(M), leaves(R).
leaves(T) --> {T =.. [_, L, R]}, leaves(L), leaves(R).
leaves(T) --> {T =.. [_, L]}, leaves(L).

tree_atom(T, A) :-
    tree_leaves(T, L),
    atom_chars(A, L).

tree_atomic_terms(T, A) :-
    phrase(atomic_term(T), Ts),
    maplist(tree_atom, Ts, A) -> true ; false.

atomic_term(T) --> {T =.. [_, L, M, R]}, atomic_term(L), atomic_term(M), atomic_term(R).
atomic_term(T) --> {T =.. [_, L, R]}, atomic_term(L), atomic_term(R).
atomic_term(T) --> {T =.. [N, L], dif(N, term)}, atomic_term(L).
atomic_term(T) --> {T =.. [term, _]}, [T].












