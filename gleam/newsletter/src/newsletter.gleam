import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  simplifile.read(path)
  |> result.map(string.trim)
  |> result.map(string.split(_, "\n"))
  |> result.nil_error
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  path
  |> simplifile.write("")
  |> result.nil_error
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  path
  |> simplifile.append(email <> "\n")
  |> result.nil_error
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email email_sender: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  let _ = create_log_file(log_path)

  read_emails(emails_path)
  |> result.unwrap([])
  |> list.map(fn(email) { send_email(email_sender, email, log_path) })
  |> result.all
  |> result.replace(Nil)
  |> result.nil_error
}

fn send_email(
  email_sender: fn(String) -> Result(Nil, Nil),
  email: String,
  log_path: String,
) {
  case email_sender(email) {
    Ok(_) -> {
      let _ = log_sent_email(log_path, email)
      Ok(Nil)
    }
    Error(_) -> Ok(Nil)
  }
}
