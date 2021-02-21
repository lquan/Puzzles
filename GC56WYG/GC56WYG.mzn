% 
% Crossfigure problem in MiniZinc.
%
% https://www.geocaching.com/geocache/GC56WYG
% all answers are positive integers, no answers begin with a zero
include "globals.mzn"; % alldifferent.mzn


int: n = 8; %grid size
array[1..n, 1..n] of var 0..9: M;

int: max_len = 6; % the max length of the numbers in this problem is 6
set of int: D = 0..(pow(10,max_len)-1); 
var D: A1;
var D: A4;
var D: A6;
var D: A8;
var D: A10;
var D: A12;
var D: A13;
var D: A14;
var D: A15;
var D: A17;
var D: A19;
var D: A21;
var D: A23;
var D: A24;


var D: D1;
var D: D2;
var D: D3;
var D: D4;
var D: D5;
var D: D7;
var D: D9;
var D: D11;
var D: D12;
var D: D13;
var D: D16;
var D: D18;
var D: D20;
var D: D22;


%
% across(Matrix, Across, Len, Row, Col)
%	Constrains 'Across' to be equal to the number represented by the
%	'Len' digits starting at position (Row, Col) of the array 'Matrix'
%	and proceeding across.
%
predicate across(array[int, int] of var 0..9: Matrix, var D: Across, int: Len, int: Row, int: Col) =
   let {
     array[1..Len] of var 0..9: tmp
   }
   in
   toNum10(tmp, Across)
   /\
   forall(i in 0..Len-1) (
       Matrix[Row,Col+i] = tmp[i+1]
   )
   /\
   Across >= pow(10, Len-1) /\ Across < pow(10, Len)
;

%
% down(Matrix, Down, Len, Row, Col):
%	Constrains 'Down' to be equal to the number represented by the
%	'Len' digits starting at position (Row, Col) of the array 'Matrix'
%	and proceeding down.
%
predicate down(array[int,int] of var 0..9: Matrix, var D: Down, int: Len, int: Row, int: Col) =
   let {
     array[1..Len] of var 0..9: tmp
   }
   in
   toNum10(tmp, Down)
   /\
   forall(i in 0..Len-1) (
      Matrix[Row+i,Col] = tmp[i+1]
   ) 
   /\
   Down >= pow(10, Len-1) /\ Down < pow(10, Len)
;



predicate different_digits(var int: a) =
  let { 
  int: size = ceil(log10(int2float(ub(a))))+1,
         array[1..size] of var 0..9: digits_a }
   in
   toNum10(digits_a, a) /\
   alldifferent(digits_a)
;

predicate toNum(array[int] of var int: a, var int: n,  int: base) =
          let { int: len = length(a) }
          in
          n = sum(i in 1..len) (
            pow(base, len-i) * a[i]
          )
          /\ forall(i in 1..len) (a[i] >= 0 /\ a[i] < base)
;

predicate toNum10(array[int] of var 0..9: a, var int: n) = toNum(a, n, 10);

predicate palindrome_array(array[int] of var int: t) =
   let { int: l = length(t), var 1..l: d } in (
   forall(j in 1..d-1) (t[j] = 0) /\
   t[d] != 0 /\
   forall(j in d..(l+d-1) div 2) (t[j] = t[l+d-j])
   )
;

predicate palindrome_int(var int: n) =
   let { int: size = ceil(log10(int2float(ub(n))))+1,
         array[1..size] of var 0..9: digits } in (
   toNum10(digits, n) /\
   palindrome_array(digits)
   )
;


%
% x is a square
% 
predicate square(var D: x) =
   %exists(y in 2..sqrt(ub(x))) (
    exists(y in D) (
         y*y = x
   )
;


%
% very simple primality test
%
predicate is_prime(var int: x) =
   forall(i in 2..ceil(sqrt(ub(x)))) ( 
        (i < x) -> (x mod i > 0)
   )
;

predicate is_perfect(var int: x) = 
  x in {6, 28, 496, 8128, 33550336, 8589869056, 137438691328};


predicate is_multiple(var int: x, var int: y) = 
  x mod y = 0;

predicate between(var int: x, var int: low, var int: high) =
  x > low /\ x < high;
  
  
  
predicate reverse_digits(var int: a, var int: b, int: len) =
  let { 
  array[1..len] of var 0..9: digits_a,
  array[1..len] of var 0..9: digits_b
  } in 
   toNum10(digits_a, a) /\ toNum10(digits_b, b) /\ forall(i in 1..len) (digits_a[i] = digits_b[len-i+1])
;
  
predicate sum_of_digits(var int: a, var int: s) = 
  let { 
  int: size = ceil(log10(int2float(ub(a))))+1,
         array[1..size] of var 0..9: digits_a }
   in
   toNum10(digits_a, a) /\
   sum(digits_a) = s
;
   
predicate fibonacci_num(var int: n) = 
  n in {1,2,3,5,8,13,21,34, 55, 89, 144,
 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229, 832040, 1346269, 2178309, 3524578, 5702887, 9227465, 14930352, 24157817, 39088169, 63245986, 102334155, 165580141, 267914296, 433494437, 701408733, 1134903170, 1836311903, 2971215073,807526976,7778742049}
;

solve :: int_search(
         [M[i,j] | i,j in 1..n] ++
         [A1,A4,A6,A8,A10,A12,A13,A14,A15,A17,A19,A21,A23,A24,
          D1,D2,D3,D4,D5,D7,D9,D11,D12,D13,D16,D18,D20,D22],
         first_fail,
         indomain_random,
         complete
         ) 
     satisfy;


constraint

   % Set up the constraints between the matrix elements and the
   % clue numbers.
   across(M, A1, 4, 1, 1)  /\ 
   across(M, A4, 3, 1, 6)  /\ 
   across(M, A6, 4, 2, 3)  /\ 
   across(M, A8, 3, 3, 1)  /\ 
   across(M, A10, 4, 3, 5)  /\ 
   across(M, A12, 2, 4, 4) /\ 
   across(M, A13, 2, 5, 1) /\ 
   across(M, A14, 2, 5, 4) /\ 
   across(M, A15, 2, 5, 7) /\ 
   across(M, A17, 3, 6, 1) /\ 
   across(M, A19, 4, 6, 5) /\ 
   across(M, A21, 4, 7, 3) /\ 
   across(M, A23, 4, 8, 1) /\ 
   across(M, A24, 3, 8, 6) /\ 

   down(M, D1, 3, 1, 1)  /\ 
   down(M, D2, 3, 1, 3)  /\ 
   down(M, D3, 2, 1, 4)  /\ 
   down(M, D4, 3, 1, 6)  /\ 
   down(M, D5, 3, 1, 8)  /\ 
   down(M, D7, 6, 2, 5)  /\ 
   down(M, D9, 4, 3, 2) /\ 
   down(M, D11, 4, 3, 7) /\ 
   down(M, D12, 2, 4, 4) /\ 
   down(M, D13, 4, 5, 1) /\ 
   down(M, D16, 4, 5, 8) /\ 
   down(M, D18, 3, 6, 3) /\ 
   down(M, D20, 3, 6, 6) /\ 
   down(M, D22, 2, 7, 4) /\ 


   % Set up the clue constraints.
%  Across
%
%  1 A14 cubed
%  4 a perfect number
%  8 A13 reversed
%  10 A14 * A24
%  12 between 10 and 100
%  13 a number divisible by 1
%  14 less than A23
%  15 an even number
%  17 A12 * A15
%  19 not a prime number
%  21 a palindrome
%  23 sum of digits is 27
%  24 greater than D3


   A1 = A14 * A14 * A14         /\ 
   is_perfect(A4)         /\ 
   reverse_digits(A6, D13, 4)         /\ 
   is_multiple(A8, D22)       /\ 
   A10 = A14 * A24        /\ 
   between(A12, 10, 100) /\ 
   is_multiple(A13, 1)       /\ 
   A14 < A23      /\ 
   is_multiple(A15, 2)       /\ 
   A17 = A12 * A15      /\ 
   not is_prime(A19)      /\ 
   palindrome_int(A21)      /\ 
   sum_of_digits(A23, 27)     /\ 
   A24 > D3      /\ 
   

   % Down
   %
   %  1 Fibonacci number
   %  2 prime number
   %  3 D11 / D5
   %  4 A4 - A13
   %  5 different digits
   %  7 A17 squared
   %  9 D13 + A1
   % 11 between 1000 and 10000
   % 12 an odd number
   % 13 D20 * 5
   % 16 a square number
   % 18 a number divisible by 8
   % 20 a number divisible by 3
   % 22 no clue
   fibonacci_num(D1) /\
   is_prime(D2) /\
   D3 = D11 / D5 /\
   D4 = A4 - A13 /\
   different_digits(D5) /\
   D7 = A17 * A17 /\
   D9 = D13 + A1 /\
   between(D11, 1000, 10000) /\
   not is_multiple(D12, 2) /\
   D13 = D20 * 5 /\
   square(D16) /\
   is_multiple(D18, 8) /\
   is_multiple(D20, 3)


   % Fix the blackboxes
   /\
   M[1,5] = 0 /\
   M[2,2] = 0 /\
   M[2,7] = 0 /\
   M[3,4] = 0 /\
   M[4,1] = 0 /\
   M[4,3] = 0 /\
   M[4,6] = 0 /\
   M[4,8] = 0 /\
   M[5,3] = 0 /\
   M[5,6] = 0 /\
   M[6,4] = 0 /\
   M[7,2] = 0 /\
   M[7,7] = 0 /\
   M[8,5] = 0 
;


output [
 "A1=\(A1),A4=\(A4),A6=\(A6),A8=\(A8),A10=\(A10),A12=\(A12),A13=\(A13),A14=\(A14),A15=\(A15),A17=\(A17),A19=\(A19),A21=\(A21),A23=\(A23),A24=\(A24),D1=\(D1),D2=\(D2),D3=\(D3),D4=\(D4),D5=\(D5),D7=\(D7),D9=\(D9),D11=\(D11),D12=\(D12),D13=\(D13),D16=\(D16),D18=\(D18),D20=\(D20),D22=\(D22)", "\n"

] ++ 
[
  if j = 1 then "\n" else " " endif ++
    show(M[i,j])
  | i,j  in 1..n
] ++ ["\n"];


output [let {var int: a = M[3,8], var int: b = M[6,7], var int: c = M[4,7], var int: d = M[8,3], var int: e = M[2,1], var int: f = M[6,8]} in "S37 51.\(a)\(b)\(c) E145 3.\(d)\(e)\(f)"];


