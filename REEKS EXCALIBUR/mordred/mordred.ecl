/*

  Fill-a-Pix problem in ECLiPSe.

  From http://www.conceptispuzzles.com/index.aspx?uri=puzzle/fill-a-pix/basiclogic
  """
  Each puzzle consists of a grid containing clues in various places. The 
  object is to reveal a hidden picture by painting the squares around each 
  clue so that the number of painted squares, including the square with 
  the clue, matches the value of the clue. 
  """
 
  Other names of this puzzle:
 
      * ã¬ã‚Šçµµãƒ‘ã‚ºãƒ«
      * Nurie-Puzzle
      * Majipiku
      * Oekaki-Pix
      * Mosaic
      * Mosaik
      * MozaÃ¯ek
      * ArtMosaico
      * Count and Darken
      * Nampre puzzle
      * Komsu Karala!
      * Cuenta Y Sombrea
      * Mosaico
      * Voisimage
      * Magipic
      * Fill-In

 
  http://www.conceptispuzzles.com/index.aspx?uri=puzzle/fill-a-pix/rules
  """
  Fill-a-Pix is a Minesweeper-like puzzle based on a grid with a pixilated 
  picture hidden inside. Using logic alone, the solver determines which 
  squares are painted and which should remain empty until the hidden picture 
  is completely exposed.
  """
  
  Fill-a-pix History:
  http://www.conceptispuzzles.com/index.aspx?uri=puzzle/fill-a-pix/history


  Compare with the following models:
  * MiniZinc: http://www.hakank.org/minizinc/fill_a_pix.mzn
  * SICStus Prolog: http://www.hakank.org/sicstus/fill_a_pix.pl

  And see the Minesweeper model:
  * http://www.hakank.org/eclipse/minesweeper.ecl



  Model created by Hakan Kjellerstrand, hakank@bonetmail.com
  See also my ECLiPSe page: http://www.hakank.org/eclipse/

*/

:-lib(ic).
%:-lib(ic_global).
%:-lib(ic_search).
%:-lib(branch_and_bound).
:-lib(listut).
%:-lib(propia).

go :-
        ( for(P,1,4) do
              printf('\nProblem %w\n',[P]),
              problem(P,Problem),
              fill_a_pix(Problem)
        ).


fill_a_pix(Problem) :-
        matrix(Problem,[R,C]), %N,N

        matrix(X,[R,C]),
		
        term_variables(X,XList),
        XList :: 0..1,

        ( for(I,1,R), 
          param(Problem,I,X,R) do
              ( for(J,1,C), 
                param(Problem,X,I,J,R,C) do
                    matrix_element(Problem,I,J,ProblemIJ),
                    ground(ProblemIJ)
              ->                    
                (
                    % sum the number of neighbors of this cell
                    ( for(A,-1,1),
                      param(X,I,J,N),
                      fromto(0,In,Out,Sum) do
                          ( for(B,-1,1),
                            param(X,I,J,A,N),
                            fromto(0,InB, OutB, BSum) do
                                I+A #>  0, J+B #>  0,
                                I+A #=< N, J+B #=< N
                          -> 
                            (
                                IA #= I+A,
                                JB #= J+B,
                                matrix_element(X,IA,JB,XIAJB),
                                OutB #= InB + XIAJB
                            )
                          ; 
                            OutB = InB
                          ),
                          Out #= In + BSum
                    ),
                    
                    % all sums must sum up to Game[I,J]
                    Sum #= ProblemIJ
                )
              ;
                true
              )        
        ),

        % search
        % labeling([min,enum,up], XList),
        labeling(XList),

        pretty_print(X),
        nl.



pretty_print(X) :-
        ( foreach(Row, X) do
          ( foreach(R, Row) do
                    R == 1 
              -> 
                    write('#')
          ;
                    write(' ')
          
          ),
          nl
        ).

matrix_element(X, I, J, Val) :-
        nth1(I, X, Row),
        nth1(J, Row, Val).


% From Mats Carlsson.
matrix(_, []) :- !.
matrix(L, [Dim|Dims]) :-
        length(L, Dim),
        (   foreach(X,L),
            param(Dims)
        do  matrix(X, Dims)
        ).



% Puzzle 1 from 
% http://www.conceptispuzzles.com/index.aspx?uri=puzzle/fill-a-pix/rules
% 
problem(1,[[_,_,_,_,_,_,_,_,0,_],
           [_,8,8,_,2,_,0,_,_,_],
           [5,_,8,_,_,_,_,_,_,_],
           [_,_,_,_,_,2,_,_,_,2],
           [1,_,_,_,4,5,6,_,_,_],
           [_,0,_,_,_,7,9,_,_,6],
           [_,_,_,6,_,_,9,_,_,6],
           [_,_,6,6,8,7,8,7,_,5],
           [_,4,_,6,6,6,_,6,_,4],
           [_,_,_,_,_,_,3,_,_,_]]).





% Puzzle 2 from 
% http://www.conceptispuzzles.com/index.aspx?uri=puzzle/fill-a-pix/rules
% 
problem(2, [[0,_,_,_,_,_,3,4,_,3],
            [_,_,_,4,_,_,_,7,_,_],
            [_,_,5,_,2,2,_,4,_,3],
            [4,_,6,6,_,2,_,_,_,_],
            [_,_,_,_,3,3,_,_,3,_],
            [_,_,8,_,_,4,_,_,_,_],
            [_,9,_,7,_,_,_,_,5,_],
            [_,_,_,7,5,_,_,3,3,0],
            [_,_,_,_,_,_,_,_,_,_],
            [4,4,_,_,2,3,3,4,3,_]]).


% Puzzle from 
% http://www.conceptispuzzles.com/index.aspx?uri=puzzle/fill-a-pix/basiclogic
%
% Code: 030.15x15
% ID: 03090000000
% 
problem(3, [[_,5,_,6,_,_,_,_,_,_,6,_,_,_,_],
            [_,_,7,6,_,4,_,_,4,_,_,8,9,_,5],
            [5,_,_,5,_,5,_,3,_,6,_,7,_,_,6],
            [4,_,2,_,4,_,4,_,3,_,2,_,_,9,_],
            [_,_,_,5,_,4,_,3,_,4,_,4,5,_,6],
            [_,4,3,3,4,_,_,_,4,_,2,_,_,_,_],
            [_,_,_,_,_,_,_,_,_,5,_,_,_,4,_],
            [3,_,3,_,_,3,_,_,_,5,_,4,4,_,_],
            [_,_,_,4,3,_,3,3,_,_,5,7,6,_,_],
            [4,_,_,_,2,_,3,3,2,_,8,9,_,5,_],
            [_,_,3,_,_,_,_,5,_,_,7,_,8,_,_],
            [4,_,_,3,2,_,_,_,_,_,7,_,_,6,_],
            [_,_,4,_,5,4,4,_,_,9,6,_,_,_,_],
            [_,3,5,7,_,6,_,_,_,_,_,_,7,_,_],
            [_,_,4,6,6,_,_,_,6,5,_,_,_,4,_]]).


			
			
problem(4, 
[
[1,2,3,3,2,2,2,3,3,2,2,2,3,2,2,2,2,2,2,3,3,2,2,1,1,0,0,1,2,3,2,2,2,3,2,2,2,3,2,2,2,3,2,1],
[2,3,4,4,3,3,2,3,4,3,4,3,5,3,4,4,4,4,3,4,3,2,3,2,2,0,0,2,3,4,2,3,3,5,3,4,3,5,3,3,2,4,3,2],
[3,4,5,5,4,4,2,3,5,4,6,4,7,4,5,4,4,5,4,5,3,2,4,3,3,0,0,3,4,5,2,4,4,7,4,6,4,7,4,4,2,5,4,3],
[3,4,5,5,4,4,2,3,5,4,6,3,6,3,4,2,2,4,4,5,3,2,4,3,3,0,0,3,4,4,1,3,3,6,3,6,3,6,3,3,1,4,4,3],
[3,4,5,5,4,5,3,4,4,3,5,3,6,3,3,0,0,2,3,4,4,3,5,3,4,2,2,4,4,4,1,3,3,6,3,6,3,6,3,3,1,4,4,3],
[3,5,7,7,5,6,5,7,6,4,5,4,7,4,3,0,0,2,4,6,7,5,6,3,5,4,4,5,5,6,3,4,4,7,4,6,4,7,4,4,3,6,5,3],
[2,3,4,4,3,4,3,4,3,2,3,3,5,3,2,0,0,1,2,3,4,3,4,2,4,4,4,4,3,4,2,3,3,5,3,4,3,5,3,3,2,4,3,2],
[1,3,4,4,2,3,3,5,5,5,5,4,5,4,3,2,2,4,5,5,5,4,5,4,4,3,2,2,3,5,5,5,4,5,4,5,5,5,4,3,3,4,3,2],
[0,2,2,2,0,2,2,3,2,3,4,3,4,4,4,4,3,4,3,2,3,3,4,3,2,1,0,0,2,3,4,4,3,4,3,4,3,2,3,2,2,2,2,2],
[0,3,3,3,0,3,3,4,2,3,5,4,5,4,4,5,4,5,3,2,4,4,5,3,2,1,0,0,3,4,5,5,4,6,4,5,3,2,4,3,3,3,3,3],
[1,4,5,5,2,4,3,4,2,3,5,4,4,2,2,4,4,5,3,2,4,4,5,3,2,1,0,0,3,3,3,3,3,6,4,5,3,2,4,4,4,4,3,3],
[1,4,5,6,3,5,3,5,3,4,4,3,2,0,0,2,3,4,4,3,4,3,4,4,3,3,2,2,4,3,3,3,3,5,3,4,4,3,5,4,5,5,4,3],
[1,4,5,7,4,6,3,6,5,7,6,4,2,0,0,2,4,6,7,5,5,4,6,7,5,5,4,4,5,4,5,5,4,5,4,6,7,5,6,4,5,5,4,3],
[0,2,2,4,2,4,2,4,3,4,3,2,1,0,0,1,2,3,4,3,3,2,3,4,3,4,4,4,4,3,4,4,3,3,2,3,4,3,4,2,3,3,3,2],
[0,1,1,2,1,2,1,2,2,3,3,2,1,0,0,1,2,3,3,2,2,2,3,3,2,2,2,2,2,2,3,3,2,2,2,3,3,2,2,1,1,1,1,1]
]
).
