defmodule Tournament do
  @moduledoc """
  Outputs a table of results given a set of games.
  """

  @initial_results %{
    wins: 0,
    losses: 0,
    draws: 0
  }

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    table_data =
      input
      |> Enum.map(&String.split(&1, ";"))
      |> convert_games_data_structure()
      |> Enum.map(&add_meta_data(&1))
      |> Enum.sort_by(&Map.fetch(&1, :points), &Kernel.>=/2)

    Tablify.display(
      [
        {"Team", :team_name},
        {"MP", :matches_played},
        {"W", :wins},
        {"D", :draws},
        {"L", :losses},
        {"P", :points}
      ],
      table_data
    )
  end

  defp convert_games_data_structure(games) do
    Enum.reduce(games, %{}, fn game, acc ->
      case game do
        [team_a, team_b, "win"] ->
          acc
          |> update_results(team_a, :wins)
          |> update_results(team_b, :losses)

        [team_a, team_b, "loss"] ->
          acc
          |> update_results(team_a, :losses)
          |> update_results(team_b, :wins)

        [team_a, team_b, "draw"] ->
          acc
          |> update_results(team_a, :draws)
          |> update_results(team_b, :draws)

        _ ->
          acc
      end
    end)
  end

  defp update_results(results, team, outcome) do
    {_get, map} =
      Map.get_and_update(results, team, fn map ->
        case map do
          nil -> {map, increment_result(@initial_results, outcome)}
          _ -> {map, increment_result(map, outcome)}
        end
      end)

    map
  end

  defp increment_result(current_team_results, outcome) do
    Map.update!(current_team_results, outcome, &(&1 + 1))
  end

  defp add_meta_data({team_name, %{wins: wins, losses: losses, draws: draws}}) do
    points = wins * 3 + draws
    matches_played = wins + draws + losses

    %{
      team_name: team_name,
      wins: Integer.to_string(wins),
      losses: Integer.to_string(losses),
      draws: Integer.to_string(draws),
      points: Integer.to_string(points),
      matches_played: Integer.to_string(matches_played)
    }
  end
end

defmodule Tablify do
  @moduledoc """
  Generic module for outputting tabular data when provided with headers and data.
  """

  def display(headers, data) do
    [generate_row(headers) | generate_row(headers, data)] |> Enum.join("\n")
  end

  defp generate_row(headers) do
    headers
    |> Enum.with_index()
    |> Enum.map(fn
      {{title, _}, 0} -> pad_initial_column(title)
      {{title, _}, _} -> pad_standard_column(title)
    end)
    |> Enum.join(" | ")
  end

  defp generate_row(headers, data) do
    data
    |> Enum.map(fn map ->
      headers
      |> Enum.with_index()
      |> Enum.map(fn
        {{_, key}, 0} -> pad_initial_column(Map.get(map, key))
        {{_, key}, _} -> pad_standard_column(Map.get(map, key))
      end)
      |> Enum.join(" | ")
    end)
  end

  defp pad_initial_column(string) do
    String.pad_trailing(string, 30)
  end

  defp pad_standard_column(string) do
    String.pad_leading(string, 2)
  end
end