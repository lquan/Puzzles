% 
% Fill-a-Pix problem in MiniZinc.
% 
% From http://www.conceptispuzzles.com/index.aspx?uri=puzzle/fill-a-pix/basiclogic
% """
% Each puzzle consists of a grid containing clues in various places. The 
% object is to reveal a hidden picture by painting the squares around each 
% clue so that the number of painted squares, including the square with 
% the clue, matches the value of the clue. 
% """
%
% Other names of this puzzle:
%
%     * ぬり絵パズル
%     * Nurie-Puzzle
%     * Majipiku
%     * Oekaki-Pix
%     * Mosaic
%     * Mosaik
%     * Mozaïek
%     * ArtMosaico
%     * Count and Darken
%     * Nampre puzzle
%     * Komsu Karala!
%     * Cuenta Y Sombrea
%     * Mosaico
%     * Voisimage
%     * Magipic
%     * Fill-In

%
% http://www.conceptispuzzles.com/index.aspx?uri=puzzle/fill-a-pix/rules
% """
% Fill-a-Pix is a Minesweeper-like puzzle based on a grid with a pixilated 
% picture hidden inside. Using logic alone, the solver determines which 
% squares are painted and which should remain empty until the hidden picture 
% is completely exposed.
% """
% 
% Fill-a-pix History:
% http://www.conceptispuzzles.com/index.aspx?uri=puzzle/fill-a-pix/history


%
% Also, see the Minesweeper model
% http://www.hakank.org/minizinc/minesweeper.mzn
%

% 
% This MiniZinc model was created by Hakan Kjellerstrand, hakank@bonetmail.com
% See also my MiniZinc page: http://www.hakank.org/minizinc
%

% include "globals.mzn"; 
int: r;
int: c;
array[1..r, 1..c] of -1..9: puzzle;
array[1..r, 1..c] of var 0..1: x;
int: X = -1; % blank

solve satisfy;
% solve :: int_search(x, first_fail, indomain_min, complete) satisfy;

constraint
    % This is from
    % http://www.hakank.org/minizinc/minesweeper.mzn
    forall(i in 1..r, j in 1..c) (
      (
       (puzzle[i,j] >= 0 )
        ->
        puzzle[i,j]  = sum(a,b in {-1,0,1} where 
            i+a > 0  /\ j+b >  0 /\
            i+a <= r /\ j+b <= c
         )
           (x[i+a,j+b])
      )
    )
;


output [
   if j = 1 then ",\n" else "," endif ++
     show(x[i,j])
   | i in 1..r, j in 1..c

]
++
["\n"]
;

r=15;
c=44;
puzzle = array2d(1..r, 1..c, [
1,2,3,3,2,2,2,3,3,2,2,2,3,2,2,2,2,2,2,3,3,2,2,1,1,0,0,1,2,3,2,2,2,3,2,2,2,3,2,2,2,3,2,1,
2,3,4,4,3,3,2,3,4,3,4,3,5,3,4,4,4,4,3,4,3,2,3,2,2,0,0,2,3,4,2,3,3,5,3,4,3,5,3,3,2,4,3,2,
3,4,5,5,4,4,2,3,5,4,6,4,7,4,5,4,4,5,4,5,3,2,4,3,3,0,0,3,4,5,2,4,4,7,4,6,4,7,4,4,2,5,4,3,
3,4,5,5,4,4,2,3,5,4,6,3,6,3,4,2,2,4,4,5,3,2,4,3,3,0,0,3,4,4,1,3,3,6,3,6,3,6,3,3,1,4,4,3,
3,4,5,5,4,5,3,4,4,3,5,3,6,3,3,0,0,2,3,4,4,3,5,3,4,2,2,4,4,4,1,3,3,6,3,6,3,6,3,3,1,4,4,3,
3,5,7,7,5,6,5,7,6,4,5,4,7,4,3,0,0,2,4,6,7,5,6,3,5,4,4,5,5,6,3,4,4,7,4,6,4,7,4,4,3,6,5,3,
2,3,4,4,3,4,3,4,3,2,3,3,5,3,2,0,0,1,2,3,4,3,4,2,4,4,4,4,3,4,2,3,3,5,3,4,3,5,3,3,2,4,3,2,
1,3,4,4,2,3,3,5,5,5,5,4,5,4,3,2,2,4,5,5,5,4,5,4,4,3,2,2,3,5,5,5,4,5,4,5,5,5,4,3,3,4,3,2,
0,2,2,2,0,2,2,3,2,3,4,3,4,4,4,4,3,4,3,2,3,3,4,3,2,1,0,0,2,3,4,4,3,4,3,4,3,2,3,2,2,2,2,2,
0,3,3,3,0,3,3,4,2,3,5,4,5,4,4,5,4,5,3,2,4,4,5,3,2,1,0,0,3,4,5,5,4,6,4,5,3,2,4,3,3,3,3,3,
1,4,5,5,2,4,3,4,2,3,5,4,4,2,2,4,4,5,3,2,4,4,5,3,2,1,0,0,3,3,3,3,3,6,4,5,3,2,4,4,4,4,3,3,
1,4,5,6,3,5,3,5,3,4,4,3,2,0,0,2,3,4,4,3,4,3,4,4,3,3,2,2,4,3,3,3,3,5,3,4,4,3,5,4,5,5,4,3,
1,4,5,7,4,6,3,6,5,7,6,4,2,0,0,2,4,6,7,5,5,4,6,7,5,5,4,4,5,4,5,5,4,5,4,6,7,5,6,4,5,5,4,3,
0,2,2,4,2,4,2,4,3,4,3,2,1,0,0,1,2,3,4,3,3,2,3,4,3,4,4,4,4,3,4,4,3,3,2,3,4,3,4,2,3,3,3,2,
0,1,1,2,1,2,1,2,2,3,3,2,1,0,0,1,2,3,3,2,2,2,3,3,2,2,2,2,2,2,3,3,2,2,2,3,3,2,2,1,1,1,1,1,
]);