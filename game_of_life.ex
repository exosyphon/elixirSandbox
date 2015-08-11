defmodule Board do
  def create_initial_board(size) do
    Enum.map(1..size, fn(_) -> generate_inner_array(size) end)
  end

  def applyRules(board) do
    Enum.map(0..Enum.count(board)-1, fn(x) -> Enum.map(0..Enum.count(board)-1, fn(y) -> check_underpopulation(board, x, y)  end)  end)
  end
 
  defp check_underpopulation(board, x, y) do
    size = Enum.count(board) - 1
    items = [[x-1,y],[x-1,y-1],[x-1,y+1],[x,y+1],[x,y-1],[x+1,y+1],[x+1,y],[x+1,y-1]]
    good_items = Enum.filter(items,fn(x) -> ( (Enum.at(x,0) >= 0 && Enum.at(x,0) <= size ) && (Enum.at(x,1) >= 0 && Enum.at(x,1) <= size ))  end)
    answer = Enum.filter(good_items, fn(x) -> getValue(board,Enum.at(x,0), Enum.at(x,1)) == true end)
    (getValue(board, x, y) && (Enum.count(answer) == 2 || Enum.count(answer) == 3) && Enum.count(answer) < 4) || (Enum.count(answer) == 3)
  end

  defp getValue(board, x, y) do
    Enum.at(board, x) |> Enum.at(y)
  end

  defp generate_inner_array(size) do
    Enum.map(1..size, fn(_) -> false end)
  end
end

ExUnit.start

defmodule GameOfLifeTest do
  use ExUnit.Case

  test 'board is an initial state' do
    assert Board.create_initial_board(3) == [[false, false, false], [false, false, false], [false, false, false]]
  end

  test 'applies the rules to an initial board' do
    initial_board = [[false, false, true],[false, false, false],[false, true, false]]
    assert Board.applyRules(initial_board) == [[false, false, false], [false, false, false], [false, false, false]] 
  end
  
  test 'keeps cells alive when applying the rules' do
    initial_board = [[true, true, true],[true, true, true],[false, true, false]]
    assert Board.applyRules(initial_board) == [[true, false, true], [false, false, false], [true, true, true]]
  end
end

