defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({op, _, args_list} = ast, acc) when op in [:def, :defp],
    do: {ast, [get_function_name_from_args_list(args_list) | acc]}

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    {_, acc} = Macro.prewalk(to_ast(string), [], &decode_secret_message_part/2)

    acc
    |> Enum.reverse()
    |> Enum.join("")
  end

  defp get_function_name_from_args_list(args_list) do
    case args_list do
      [{:when, _, args_list} | _] ->
        get_function_name_from_args_list(args_list)

      [node | _] ->
        # NOTE: This is NOT tail-call optimised
        # TODO: Change this to return the function name and arguments and trim
        # when decoding
        trim_function_name(node)
    end
  end

  defp trim_function_name({function_name, _, args_list}),
    do: Atom.to_string(function_name) |> String.slice(0, length(args_list || []))
end
