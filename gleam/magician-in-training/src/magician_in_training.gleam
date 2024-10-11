import gleam/queue.{type Queue}

pub fn insert_top(queue: Queue(Int), card: Int) -> Queue(Int) {
  card |> queue.push_back(queue, _)
}

pub fn remove_top_card(queue: Queue(Int)) -> Queue(Int) {
  case queue.pop_back(queue) {
    Ok(#(_, queue)) -> queue
    _ -> queue.new()
  }
}

pub fn insert_bottom(queue: Queue(Int), card: Int) -> Queue(Int) {
  card |> queue.push_front(queue, _)
}

pub fn remove_bottom_card(queue: Queue(Int)) -> Queue(Int) {
  case queue.pop_front(queue) {
    Ok(#(_, queue)) -> queue
    _ -> queue.new()
  }
}

pub fn check_size_of_stack(queue: Queue(Int), target: Int) -> Bool {
  queue.length(queue) == target
}
