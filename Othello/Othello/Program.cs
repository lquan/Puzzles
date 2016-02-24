using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Othello
{
  //https://www.reddit.com/r/dailyprogrammer/comments/468pvf/20160217_challenge_254_intermediate_finding_legal/
  class Board
  {
    public enum Square { Empty, X, O, }

    private Square[,] board;
    public Board(int n)
    {
      board = new Square[n,n]; 
    }


    public static Board GetBoard(List<string> lines)
    {
      var result = new Board(lines.Count);
      for(int i = 0; i < lines.Count; i++)
      {
        string line = lines[i];
        for(int j = 0; j < line.Length; j++)
        {
          result.board[i, j] = GetSquare(line[j].ToString());
        }
      }
      return result;
    }


    public static Square GetSquare(string c)
    {
      switch (c)
      {
        case "-":
          return Square.Empty;
        case "O":
          return Square.O;
        case "X":
          return Square.X;
        default:
          throw new NotSupportedException();
      }
    }

    public IEnumerable<Tuple<int, int>> FindLegalMoves(Square s)
    {
      int n = board.GetLength(0);
      int m = board.GetLength(1);

      for (int i = 0; i < n; i++)
      {
        for (int j = 0; j < m; j++)
        {
          if (IsLegalMove(s, i, j))
          {
            yield return Tuple.Create(i, j);
          }
        }
      }
    }

    public bool IsLegalMove(Square s, int i, int j)
    {
      if (board[i, j] == Square.Empty)
      {
        return false;
      }

      int n = board.GetLength(0);
      int m = board.GetLength(1);

      //go right
      for(int i =
    }



  }
  class Program
  {


    const string input =
@"X
--------
--------
--------
---OX---
---XO---
--------
--------
--------";

    static void Main(string[] args)
    {
      var boardInput = new List<string>();
      string current;

      using (var reader = new System.IO.StringReader(input))
      {
        current = reader.ReadLine();

        string line;
        while ((line = reader.ReadLine()) != null)
        {
          boardInput.Add(line);
        }
      }

      var board = Board.GetBoard(boardInput);

    }
  }
}
