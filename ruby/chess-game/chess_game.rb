module Chess
  RANKS = 1..8
  FILES = 'A'..'H'

  def self.valid_square?(rank, file)
    rank in RANKS and file in FILES
  end

  def self.nick_name(first_name, last_name)
    (first_name.chars.first(2) + last_name.chars.last(2)).join.upcase
  end

  def self.move_message(first_name, last_name, square)
    rank = square.chars.last.to_i
    file = square.chars.first
    nick_name = nick_name(first_name, last_name)

    return "#{nick_name} moved to #{square}" if valid_square?(rank, file)

    "#{nick_name} attempted to move to #{square}, but that is not a valid square"
  end
end
