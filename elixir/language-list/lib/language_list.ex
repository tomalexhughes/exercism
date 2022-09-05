defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove(list) do
    [_first | rest] = list
    rest
  end

  def first(list) do
    Enum.at(list, 0)
  end

  def count(list) do
    Enum.count(list)
  end

  def functional_list?(list) do
    Enum.member?(list, "Elixir")
  end
end
