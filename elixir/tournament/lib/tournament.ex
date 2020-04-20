defmodule Tournament do
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
    input
    |> Enum.map(&String.split(&1, ";"))
    |> Enum.reduce(%{}, fn game, acc ->
      case game do
        [team_a, team_b, "win"] ->
          acc
          |> Map.update(team_a, @initial_results, &increment_result(&1, :wins))
          |> Map.update(team_b, @initial_results, &increment_result(&1, :losses))

        [team_a, team_b, "loss"] ->
          acc
          |> Map.update(team_a, @initial_results, &increment_result(&1, :losses))
          |> Map.update(team_b, @initial_results, &increment_result(&1, :wins))

        [team_a, team_b, _result] ->
          acc
          |> Map.update(team_a, @initial_results, &increment_result(&1, :draws))
          |> Map.update(team_b, @initial_results, &increment_result(&1, :draws))
      end
    end)
  end

  defp increment_result(current_team_results, outcome) do
    Map.update!(current_team_results, outcome, &(&1 + 1))
  end
end
