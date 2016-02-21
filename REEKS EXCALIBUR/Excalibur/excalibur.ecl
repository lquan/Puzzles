:- lib(ic).

excalibur(Digits) :-
    Digits = [X,C,A,L,I,B,U,R],
    Digits :: [0..9],
	A + L + B #= U,
	A + I #= R,
	L + U + A #= R,
	X #= C,
	X #= L - B,
	I + R #= 15,
	X + C + A + L + I + B + U + R #= 25,
	U + B #= I,
	2*A #= I,
    labeling(Digits).