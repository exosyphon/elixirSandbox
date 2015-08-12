defmodule Game do
  def start(initial_board) do
    Output.print_board(initial_board)
    new_board = Board.applyRules(initial_board)
    :timer.sleep(1000)
    start(new_board)
  end
end

defmodule Output do
  def print_board(board) do
    Enum.each(0..Board.get_board_size(board), fn(x) -> Enum.each(0..Board.get_board_size(board), fn(y) -> print(board, x, y)  end)  end)
  end

  defp print(board, x, y) do
    if(Board.getValue(board, x, y)) do
      :io.format " X "
    else
      :io.format " O "
    end

    board_size = Board.get_board_size(board)
    if(y == board_size) do
      IO.puts " " 
    end
    if(x == board_size && y == board_size) do
      IO.puts " " 
    end
  end
end

defmodule Board do
  def get_board_size(board) do
    Enum.count(board)-1
  end

  def create_random_board(size) do
    Enum.map(0..size-1, fn(x) -> random_inner_array(size) end)
  end

  def create_initial_board(size) do
    Enum.map(0..size-1, fn(x) -> generate_inner_array(x, size) end)
  end

  def applyRules(board) do
    Enum.map(0..get_board_size(board), fn(x) -> Enum.map(0..get_board_size(board), fn(y) -> check_rules(board, x, y)  end)  end)
  end
 
  def getValue(board, x, y) do
    Enum.at(board, x) |> Enum.at(y)
  end

  defp check_rules(board, x, y) do
    coordinates = [[x-1,y],[x-1,y-1],[x-1,y+1],[x,y+1],[x,y-1],[x+1,y+1],[x+1,y],[x+1,y-1]]
    valid_coordinates = Enum.filter(coordinates,fn(x) -> ( (Enum.at(x,0) >= 0 && Enum.at(x,0) <= get_board_size(board) ) && (Enum.at(x,1) >= 0 && Enum.at(x,1) <= get_board_size(board))) end)
    neighbors_alive = Enum.filter(valid_coordinates, fn(x) -> getValue(board,Enum.at(x,0), Enum.at(x,1)) == true end)
    cell_dies(board, x, y, neighbors_alive) || cell_reproduces(neighbors_alive)
  end

  defp cell_reproduces(neighbors_alive) do
    Enum.count(neighbors_alive) == 3
  end

  defp cell_dies(board, x, y, neighbors_alive) do
    getValue(board, x, y) && Enum.count(neighbors_alive) > 1 && Enum.count(neighbors_alive) < 4
  end

  def random_inner_array(size) do
    if(:random.uniform >= 0.5) do
      Enum.map(0..size-1, fn(_) -> true end)
    else
      Enum.map(0..size-1, fn(_) -> false end)
    end
  end

  defp generate_inner_array(x, size) do
    if(x == 0) do
      Enum.map(0..size-1, fn(_) -> true end)
    else
      Enum.map(0..size-1, fn(_) -> false end)
    end
  end
end

Game.start(Board.create_random_board(30))

ExUnit.start

defmodule GameOfLifeTest do
  use ExUnit.Case

  test 'board is an initial state' do
    assert Board.create_initial_board(3) == [[true, true, true], [false, false, false], [false, false, false]]
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

