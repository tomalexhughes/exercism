class Squares
  attr_reader :range

  def initialize(input)
    @range = (1..input)
  end

  def square_of_sum
    range.sum.abs2
  end

  def sum_of_squares
    range.sum(&:abs2)
  end

  def difference
    square_of_sum - sum_of_squares
  end
end
