defmodule Braille do
  def call(phrase) do
    String.codepoints(phrase) |> Enum.map(fn x -> Translate.translate_letter x end)
  end
end

defmodule Translate do
  def translate_letter(letter) do
    cond do
      String.match?(letter, ~r/^\p{Lu}$/u) -> add_capital(letter) 
      true -> map(letter)
    end
  end

  defp add_capital(letter) do
    [[["", ""], ["", ""], ["", "X"]], map(String.downcase(letter))]
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
    assert Translate.translate_letter("A") == [[["", ""], ["", ""], ["", "X"]], [["X", ""], ["", ""], ["", ""]]]
  end

  test "can translate an entire lowercase word" do
    assert Braille.call("hi") == [[["X", ""], ["X", "X"], ["", ""]],[["", "X"], ["X", ""], ["", ""]]]
  end

  test "can translate an entire word" do
    assert Braille.call("Hi") == [[["", ""], ["", ""], ["", "X"]], [["X", ""], ["X", "X"], ["", ""]], [["", "X"], ["X", ""], ["", ""]]]
  end
end

