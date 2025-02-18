# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  use Agent

  def start(opts \\ []) do
    Agent.start(fn -> %{plots: [], next_id: 1} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{plots: plots, next_id: next_id} ->
      new_plot = %Plot{
        plot_id: next_id,
        registered_to: register_to
      }

      {new_plot, %{plots: [new_plot | plots], next_id: next_id + 1}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      %{state | plots: Enum.filter(state.plots, fn plot -> plot.plot_id !== plot_id end)}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state ->
      Enum.find(state.plots, {:not_found, "plot is unregistered"}, fn plot ->
        plot.plot_id === plot_id
      end)
    end)
  end
end
