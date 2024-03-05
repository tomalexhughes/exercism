defmodule Robot do
  defstruct direction: :north, x: 0, y: 0
end

defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]

  defguardp is_position(x, y) when is_integer(x) and is_integer(y)
  defguardp is_direction(direction) when direction in @directions

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any

  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, _position) when not is_direction(direction),
    do: {:error, "invalid direction"}

  def create(direction, {x, y}) when is_position(x, y),
    do: %Robot{direction: direction, x: x, y: y}

  def create(_direction, _position), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, ""), do: robot
  def simulate({:error, reason}, _), do: {:error, reason}

  def simulate(robot, <<command::binary-size(1), tail::binary>>) do
    robot = process_command(command, robot)
    simulate(robot, tail)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    {robot.x, robot.y}
  end

  defp process_command("R", robot), do: rotate_clockwise(robot)
  defp process_command("L", robot), do: rotate_counter_clockwise(robot)
  defp process_command("A", robot), do: advance(robot)
  defp process_command(_, _), do: {:error, "invalid instruction"}

  defp rotate_clockwise(%{direction: :north} = robot), do: %{robot | direction: :east}
  defp rotate_clockwise(%{direction: :east} = robot), do: %{robot | direction: :south}
  defp rotate_clockwise(%{direction: :south} = robot), do: %{robot | direction: :west}
  defp rotate_clockwise(%{direction: :west} = robot), do: %{robot | direction: :north}

  defp rotate_counter_clockwise(robot),
    do: robot |> rotate_clockwise() |> rotate_clockwise() |> rotate_clockwise()

  defp advance(%{direction: :north, y: y} = robot), do: %{robot | y: y + 1}
  defp advance(%{direction: :east, x: x} = robot), do: %{robot | x: x + 1}
  defp advance(%{direction: :south, y: y} = robot), do: %{robot | y: y - 1}
  defp advance(%{direction: :west, x: x} = robot), do: %{robot | x: x - 1}
end
