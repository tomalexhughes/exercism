defmodule LogLevel do
  @log_levels %{
    0 => {:trace, false},
    1 => {:debug, true},
    2 => {:info, true},
    3 => {:warning, true},
    4 => {:error, true},
    5 => {:fatal, false}
  }

  defguardp is_known_log_level(level) when is_map_key(@log_levels, level)
  defp is_legacy_log_level(level), do: @log_levels[level] |> elem(1)

  def to_label(level, _) when not is_known_log_level(level), do: :unknown

  def to_label(level, legacy?) do
    {label, legacy_support} = @log_levels[level]
    if legacy? && !legacy_support, do: :unknown, else: label
  end

  def alert_recipient(level, legacy?) do
    cond do
      !is_known_log_level(level) && legacy? -> :dev1
      !is_known_log_level(level) -> :dev2
      !is_legacy_log_level(level) && legacy? -> :dev1
      level === 4 -> :ops
      level === 5 -> :ops
      true -> nil
    end
  end
end
