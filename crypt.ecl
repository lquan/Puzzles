%
% A somewhat generalised "cryptarithmetic" solver
%
% Author:	J.Schimpf, IC-Parc
%
% Examples:
%
% ?- cryptarith([S,E,N,D] + [M,O,R,E] = [M,O,N,E,Y], 10).
% 
% ?- cryptarith([D,O,N,A,L,D] + [G,E,R,A,L,D] = [R,O,B,E,R,T], 10).
% 
% ?- cryptarith([S,I,X] + [S,I,X] + [S,I,X] + [B,E,A,S,T] = [S,A,T,A,N], 10).
% 
% By Jim Gillogly, rec.puzzles 2003-09-05 (base 12, 2 solutions):
% ?- cryptarith([[K,K,K] = [6,6,6],
%                [K,K,K] = [G,E,O,R,G,E] - [W,A,L,K,E,R] + [B,U,S,H]], 12).
%
% By Jayavel Sounderpandian, rec.puzzles 2005-11-13
% ?- cryptarith([Y] * [W,O,R,R,Y] = [D,O,O,O,O,D], 10).


:- lib(ic).
:- lib(ic_search).



%[[2, 9, 8, 1] + [6, 8, 2] = [3, 6, 6, 3],
% [1, 4, 7, 1] + [4, 0, 8] = [1, 8, 7, 9], 
% [1, 5, 1, 0] + [2, 7, 4] = [1, 7, 8, 4],
% [2, 9, 8, 1] - [1, 4, 7, 1] = [1, 5, 1, 0], 
% [6, 8, 2] - [4, 0, 8] = [2, 7, 4],
% [3, 6, 6, 3] - [1, 8, 7, 9] = [1, 7, 8, 4]]

solve(1) :-
	cryptarith([
	[L,S,N,T] + [U,N,L] = [R,U,U,R], 
	[T,P,M,T] + [P,O,N] = [T,N,M,S], 
	[T,Q,T,O] + [L,M,P] = [T,M,N,P], 
	
	[L,S,N,T] - [T,P,M,T] = [T,Q,T,O], 
	[U,N,L] - [P,O,N] = [L,M,P], 
	[R,U,U,R] - [T,N,M,S] = [T,M,N,P]],
	
	10).
	
cryptarith(Equations, Base) :-
	term_variables(Equations, Digits),
	Digits :: 0..Base-1,
	alldifferent(Digits),
	constraint(Equations, Base),
	search(Digits, 0, first_fail, indomain, complete, []),
	writeln(Equations).

constraint([], _).
constraint([C|Cs], Base) :-
	constraint(C, Base),
	constraint(Cs, Base).
constraint(E1=E2, Base) :-
	expression(E1, CE1, Base),
	expression(E2, CE2, Base),
	eval(CE1) #= eval(CE2).
	
expression(E1+E2, CE1+CE2, Base) :-
	expression(E1, CE1, Base),
	expression(E2, CE2, Base).
expression(E1-E2, CE1-CE2, Base) :-
	expression(E1, CE1, Base),
	expression(E2, CE2, Base).
expression(E1*E2, CE1*CE2, Base) :-
	expression(E1, CE1, Base),
	expression(E2, CE2, Base).
expression(Digits, sum(WeightedDigits), Base) :-
	Digits = [First|_],
	First #\= 0,
	(
	    for(I,length(Digits)-1,0,-1),
	    foreach(D,Digits),
	    foreach(P*D,WeightedDigits),
	    param(Base)
	do
	    P is Base^I
	).
