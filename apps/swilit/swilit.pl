/*Core functionality
 * -----------------
 * 1. parse search query to a tree where leaves are search terms and
 * nodes are set operators (and = intersection, or = union, not =
 * difference, etc.)
 * 2. the parse tree is the central piece of the application
 * 3. get PID set by querying PubMed for all tree leaves
 * 4. evaluate influence of search term by weighting on the returned PID
 * number and other various characteristics.
 * 5. synthesize modified queries based on user specs from the parse
 * tree, by evaluating set operations, etc.
 * 6. make a GUI for easy handling (probably easier as distinct process
 * through JSON serialization, but pengines is an alternative).
 */

:- module(swilit, []).





/*
:- use_module(query).

% example of getting record count as a number
query_main(Y):-
    query_entrez('esearch',
                 pubmed,
                 "atherosclerosis AND stent",
                 0,
                 20,
                 count,
                 1900,
                 2019,
                 X),
    number_string(Y, X.esearchresult.count).
*/






