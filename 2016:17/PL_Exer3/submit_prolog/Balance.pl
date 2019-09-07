/* Balance Prolog - VAVOULIOTIS(03112083) - ATHANASIOU(03112074) */

my_matrix(ACC,A,B) :- 
(   ACC = 0  -> A is 0, 		 B is 0;
	ACC = 1  -> A is 1,			 B is 1;
	ACC = 2  -> A is 3, 		 B is 4;
	ACC = 3  -> A is 9, 		 B is 13;
	ACC = 4  -> A is 27,		 B is 40;
	ACC = 5  -> A is 81, 		 B is 121;
	ACC = 6  -> A is 243,        B is 364;
	ACC = 7  -> A is 729,        B is 1093;
	ACC = 8  -> A is 2187,       B is 3280;
	ACC = 9  -> A is 6561,       B is 9841;
	ACC = 10 -> A is 19683,      B is 29524;
	ACC = 11 -> A is 59049,      B is 88573;
	ACC = 12 -> A is 177147,     B is 265720;
	ACC = 13 -> A is 531441,     B is 797161;
	ACC = 14 -> A is 1594323,    B is 2391484;
	ACC = 15 -> A is 4782969,    B is 7174453;
	ACC = 16 -> A is 14348907,   B is 21523360;
	ACC = 17 -> A is 43046721,   B is 64570081;
	ACC = 18 -> A is 129140163,  B is 193710244;
	ACC = 19 -> A is 387420489,  B is 581130733;
	ACC = 20 -> A is 1162261467, B is 1743392200
).

myreverse([],Z,Z).
myreverse([H|T],Z,Acc) :- myreverse(T,Z,[H|Acc]).

my_between(X,Y,Z):- Y >= X, Y =< Z . 

myabs(X,Y) :- ( X < 0 -> Y is -X ; Y = X ).

acc_runner(N, W, Renew):-
	my_between(0,N,20), my_matrix(N, A1, U1),
   ( not(W =< U1) -> Renew is N+1 ; New is N-1, acc_runner(New, W, Renew) ).

computations(N, 0, L, R):- 
	L = [], R = [],
	!.
computations(N, W, L, R):-
	 (  N = 0 -> fail;
		RenewVal is N-1, my_between(0,N,20), my_matrix(N, A2, U2), my_matrix(RenewVal, P2, S2), myabs(W+A2, Y), myabs(W-A2, X),
		( not(X > S2) -> R  = [N|Tail], RenewVal2 is W - A2, computations(RenewVal, RenewVal2, L, Tail);
		  not(Y > S2) -> L  = [N|Tail], RenewVal2 is W + A2, computations(RenewVal, RenewVal2, Tail, R);
		  computations(RenewVal, W, L, R)
		)
	 ).

balance(N, W, L, R):-
	my_between(0,N,20), my_matrix(N, A1, U1), not(W > U1), acc_runner(N, W, TempRes), computations(TempRes, W, LRes, RRes), myreverse(LRes, L,[]), myreverse(RRes, R,[]).
	