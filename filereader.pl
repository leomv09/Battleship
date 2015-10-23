main(Lines, FileName) :-
    open(FileName, read, Str),
    read_file(Str,Lines),
    close(Str),
    !.

read_file(end_of_file,_ ):- !.

read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+at_end_of_stream(Stream),
    read(Stream,X),
    read_file(Stream,L).

get_board(B):-
  main(B,'my_board').

get_cols([_,H|_], H).
get_cols(C) :-
  main(Xs, 'opponent'),
  get_cols(Xs, Ys),
  atom_chars(Ys,Zs),
  convert(Zs, C).

get_rows([H|_], H).
get_rows(R) :-
  main(Xs, 'opponent'),
  get_rows(Xs, Ys),
  atom_chars(Ys,Zs),
  convert(Zs, R).

convert([],[]).
convert([H1|T1], [H2|T2]) :-
  convert(T1, T2),
  atom_number(H1,H2).
