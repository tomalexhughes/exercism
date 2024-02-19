defmodule TakeANumber do
  def start() do
    spawn(&loop/0)
  end

  defp loop(number \\ 0) do
    # If there are no messages in the mailbox,
    # or none of messages in the mailbox match any of the patterns,
    # receive/1 is going to wait for one.
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, number)
        loop(number)

      {:take_a_number, sender_pid} ->
        send(sender_pid, number + 1)
        loop(number + 1)

      :stop ->
        nil

      # Keep waiting for messages after receiving an unexpected message
      _ ->
        loop(number)
    end
  end
end
