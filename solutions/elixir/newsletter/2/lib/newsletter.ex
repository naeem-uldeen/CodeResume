defmodule Newsletter do

  def send_newsletter(emails_path, log_path, send_fun) when
    is_binary(emails_path) and is_binary(log_path) and
    is_function(send_fun, 1) do
      with emails <- read_emails(emails_path),
         log <- open_log(log_path),
         :ok <- deliver_all(emails, send_fun, log) do
      close_log(log)
    end
  end

  def read_emails(path) when
    is_binary(path) do
      path
      |> File.read!()
      |> String.split("\n", trim: true)
  end

  def open_log(path) when
    is_binary(path), do: File.open!(path, [:write])

  def deliver_all(emails, send_fun, log) when
    is_list(emails) and
    is_function(send_fun, 1) and
    is_pid(log) do
      Enum.each(emails, fn email ->
        case send_fun.(email) do
          :ok -> log_sent_email(log, email)
          _ -> :error
        end
      end)
      :ok
  end

  def log_sent_email(log, email) when
    is_pid(log) and is_binary(email),
    do: IO.puts(log, email)

  def close_log(log) when
    is_pid(log), do: File.close(log)

end
