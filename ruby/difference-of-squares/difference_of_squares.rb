class Squares
  attr_reader :range

  def initialize(input)
    @range = (1..input)
  end

  def square_of_sum
    range.sum**2
  end

  def sum_of_squares
    range.map { |val| val**2 }.sum
  end

  def difference
    square_of_sum - sum_of_squares
  end
end
