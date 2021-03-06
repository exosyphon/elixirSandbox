defmodule Braille do
  def call(phrase) do
    String.codepoints(phrase) |> Enum.reduce([], fn(x, acc) -> 
    acc = [Translate.add_cap(x, String.upcase(x)) | acc]
    [Translate.translate_letter(String.downcase(x)) | acc]
    end) |> Enum.reverse |> Enum.reject(&(is_nil(&1)))
  end
end

defmodule Translate do
  def translate_letter(letter) do
    map(letter)
  end

  def add_cap(" ", " ") do
    [["", ""], ["", ""], ["", ""]]
  end

  def add_cap(capital, capital) do
    [["", ""], ["", ""], ["", "X"]]
  end

  def add_cap(not_capital, capital) do
  end

  defp map(letter) do
    %{
      "a" => [["X", ""], ["", ""], ["", ""]],
      "b" => [["X", ""], ["X", ""], ["", ""]],
      "c" => [["X", "X"], ["", ""], ["", ""]],
      "d" => [["X", "X"], ["", "X"], ["", ""]],
      "e" => [["X", ""], ["", "X"], ["", ""]],
      "f" => [["X", "X"], ["X", ""], ["", ""]],
      "g" => [["X", "X"], ["X", "X"], ["", ""]],
      "h" => [["X", ""], ["X", "X"], ["", ""]],
      "i" => [["", "X"], ["X", ""], ["", ""]],
      "j" => [["", "X"], ["X", "X"], ["", ""]],
      "k" => [["X", ""], ["", ""], ["X", ""]],
      "l" => [["X", ""], ["X", ""], ["X", ""]],
      "m" => [["X", "X"], ["", ""], ["X", ""]],
      "n" => [["X", "X"], ["", "X"], ["X", ""]],
      "o" => [["X", ""], ["", "X"], ["X", ""]],
      "p" => [["X", "X"], ["X", ""], ["X", ""]],
      "q" => [["X", "X"], ["X", "X"], ["X", ""]],
      "r" => [["X", ""], ["X", "X"], ["X", ""]],
      "s" => [["", "X"], ["X", ""], ["X", ""]],
      "t" => [["", "X"], ["X", "X"], ["X", ""]],
      "u" => [["X", ""], ["", ""], ["X", "X"]],
      "v" => [["X", ""], ["X", ""], ["X", "X"]],
      "w" => [["", "X"], ["X", "X"], ["", "X"]],
      "x" => [["X", "X"], ["", ""], ["X", "X"]],
      "y" => [["X", "X"], ["", "X"], ["X", "X"]],
      "z" => [["X", ""], ["", "X"], ["X", "X"]],
    }[letter]
  end
end


ExUnit.start

defmodule BrailleTest do
  use ExUnit.Case

  test "translates a letter to braille" do
    assert Translate.translate_letter("a") == [["X", ""], ["", ""], ["", ""]]
    assert Translate.translate_letter("b") == [["X", ""], ["X", ""], ["", ""]]
  end

  test "translates a capital letter to braille" do
    assert Braille.call("A") == [[["", ""], ["", ""], ["", "X"]], [["X", ""], ["", ""], ["", ""]]]
  end

  test "can translate an entire lowercase word" do
    assert Braille.call("hi") == [[["X", ""], ["X", "X"], ["", ""]],[["", "X"], ["X", ""], ["", ""]]]
  end

  test "can translate an entire word" do
    assert Braille.call("Hi") == [
      [["", ""], ["", ""], ["", "X"]], 
      [["X", ""], ["X", "X"], ["", ""]], [["", "X"], ["X", ""], ["", ""]]
    ]
  end

  test "can translate an entire sentence" do
    assert Braille.call("Hi there") == [
      [["", ""], ["", ""], ["", "X"]], [["X", ""], ["X", "X"], ["", ""]], 
      [["", "X"], ["X", ""], ["", ""]],
      [["", ""], ["", ""], ["", ""]], 
      [["", "X"], ["X", "X"], ["X", ""]],
      [["X", ""], ["X", "X"], ["", ""]],
      [["X", ""], ["", "X"], ["", ""]],
      [["X", ""], ["X", "X"], ["X", ""]],
      [["X", ""], ["", "X"], ["", ""]],
    ]
  end
end
[["", ""], ["", ""], ["", "X"]] 
