read_and_return(File, [R1, R2, R3, R4, R5, R6, R7]):-
	open(File, read, Stream),
    read_line(Stream, R1),
	read_line(Stream, R2),
	read_line(Stream, R3),
	read_line(Stream, R4),
	read_line(Stream, R5),
	read_line(Stream, R6),
	read_line(Stream, R7),
	close(Stream).

read_line(Stream, List):-
    read_line_to_codes(Stream, Line),
    atom_codes(A, Line),
    atomic_list_concat(As, ' ', A),
    maplist(atom_number, As, List).



myins([_|T], 1, X, [X|T]).
myins([H|T], I, X, [H|R]):- I > 0, NI is I-1, myins(T, NI, X, R).
myins(L, _, _, L).





change_pos([R1, R2, R3, R4, R5, R6, R7], X, J, Op, Ret):- (X=1 -> myins(R1, J, Op, Fine), Ret = [Fine, R2, R3, R4, R5, R6, R7];
							  X=2 -> myins(R2, J, Op, Fine), Ret = [R1, Fine, R3, R4, R5, R6, R7];
							  X=3 -> myins(R3, J, Op, Fine), Ret = [R1, R2, Fine, R4, R5, R6, R7];
							  X=4 -> myins(R4, J, Op, Fine), Ret = [R1, R2, R3, Fine, R5, R6, R7];
							  X=5 -> myins(R5, J, Op, Fine), Ret = [R1, R2, R3, R4, Fine, R6, R7];
							  X=6 -> myins(R6, J, Op, Fine), Ret = [R1, R2, R3, R4, R5, Fine, R7];
							  X=7 -> myins(R7, J, Op, Fine), Ret = [R1, R2, R3, R4, R5, R6, Fine]).
							  


rearr_colums(0, [_|L], E, [E|L]).
rearr_colums(N, [X|L], E, [X|R]) :-
  succ(M, N),
  rearr_colums(M, L, E, R). 



change_dom([R1, R2, R3, R4, R5, R6, R7], Index, J, Op, Ret):- (Index=0 -> rearr_colums(J,R1, Op, Fine), Ret = [Fine, R2, R3, R4, R5, R6, R7];
							Index=1 ->   rearr_colums(J,R2, Op, Fine), Ret = [R1, Fine, R3, R4, R5, R6, R7];
							Index=2 ->   rearr_colums(J,R3, Op, Fine), Ret = [R1, R2, Fine, R4, R5, R6, R7];
							Index=3 ->   rearr_colums(J,R4, Op, Fine), Ret = [R1, R2, R3, Fine, R5, R6, R7];
							Index=4 ->   rearr_colums(J,R5, Op, Fine), Ret = [R1, R2, R3, R4, Fine, R6, R7];
							Index=5 ->   rearr_colums(J,R6, Op, Fine), Ret = [R1, R2, R3, R4, R5, Fine, R7];
							Index=6 ->   rearr_colums(J,R7, Op, Fine), Ret = [R1, R2, R3, R4, R5, R6,Fine]).

find_col([H|_],1,H).
find_col([_|T],X,Res):- X1 is X-1,find_col(T,X1,Res).




pars_array([R1|_],1,J,Res):-find_col(R1, J, Res), !.
pars_array([_|T],I,J,Res):- I>0,I1 is I-1,pars_array(T,I1,J,Res).

dom_find_col([Ret|_],0,Ret).
dom_find_col([_|T],I,Ret):- I > -1,I1 is I-1,dom_find_col(T,I1,Ret).


pars_domino([R1|_],0,J,Res):- dom_find_col(R1, J, Res), !.
pars_domino([_|T],I,J,Res):- I > -1,I1 is I-1,pars_domino(T,I1,J,Res).




validate(_, 8, _, _):- fail.
validate([L|Ls], Row, I, J):-
	(	find_col(L, 1, 1) -> I = Row, J = 1
	;	find_col(L, 2, 1) -> I = Row, J = 2
	;	find_col(L, 3, 1) -> I = Row, J = 3
	;	find_col(L, 4, 1) -> I = Row, J = 4
	;	find_col(L, 5, 1) -> I = Row, J = 5
	;	find_col(L, 6, 1) -> I = Row, J = 6
	;	find_col(L, 7, 1) -> I = Row, J = 7
	;	find_col(L, 8, 1) -> I = Row, J = 8
	;	New_Row is Row+1,
		validate(Ls, New_Row, I, J)
	).
combos(Space, Matrx, Domino, VI, PI, RESULT):-
	pars_array(Space, VI, PI, A),
	change_pos(Matrx, VI, PI, 0, RenewMatr),
	RenewVal is VI+1,
	RenewVal1 is PI+1,
	(	pars_array(Matrx, VI, RenewVal1, 1),
		pars_array(Space, VI, RenewVal1, B),
		pars_domino(Domino, A, B, 1) ->
		change_pos(RenewMatr, VI, RenewVal1, 0, RenewMatr2),
		change_dom(Domino, A, B, 0, DominoNew),
		change_dom(DominoNew, B,  A, 0, DominoLast),
		!,
		(	validate(RenewMatr2, 1, VAL1, VAL2) -> 
				ACC = 0,
				combos(Space, RenewMatr2, DominoLast, VAL1, VAL2, RES)
		;	ACC = 1,
			RES = 0
		)
	;	ACC = 0,
		RES = 0
	),
	(	pars_array(Matrx, RenewVal, PI, 1),
		pars_array(Space, RenewVal, PI, C),
		pars_domino(Domino, A, C, 1) ->
		change_pos(RenewMatr, RenewVal, PI, 0, MATR2),
		change_dom(Domino, A, C, 0, Domino3),
		change_dom(Domino3, C,  A, 0, Domino4),
		!,
		(	validate(MATR2, 1, IND2, IN2) ->
				ACC2 = 0,
				combos(Space, MATR2, Domino4, IND2, IN2, RES2)
		;	ACC2 = 1,
			RES2 = 0
		)
	;	ACC2 = 0,
		RES2 = 0
	),
	RESULT is ACC+ACC2+RES+RES2.
combos( _, _, _, _, _, 0).

dominos(Input, N):-
	read_and_return(Input, Grid),
combos(Grid, [[1, 1, 1, 1, 1, 1, 1, 1],[1, 1, 1, 1, 1, 1, 1, 1],[1, 1, 1, 1, 1, 1, 1, 1],[1, 1, 1, 1, 1, 1, 1, 1],[1, 1, 1, 1, 1, 1, 1, 1],[1, 1, 1, 1, 1, 1, 1, 1],	[1, 1, 1, 1, 1, 1, 1, 1]], [[1, 1, 1, 1, 1, 1, 1, 1],[1, 1, 1, 1, 1, 1, 1, 1],[1, 1, 1, 1, 1, 1, 1, 1],[1, 1, 1, 1, 1, 1, 1, 1],[1, 1, 1, 1, 1, 1, 1, 1],[1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1]], 1, 1, N),
	!.
		 
	
	
	
	
	
	
	
	
	
	
	
	
