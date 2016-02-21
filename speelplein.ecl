:- lib(ic).

speelplein(Digits) :-
    Digits = [E,A,C,D,B,F],
    Digits :: [0..9],
	D #= A * 2,
	E * A #= 24,
	E + A + C + D + B + F #= 35,
	C - B #= E,
	A + F #= C ,
	
    labeling(Digits).