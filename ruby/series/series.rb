class Series
  def initialize(digits_string)
    @digits_string = digits_string
  end

  def slices(size)
    raise ArgumentError if size > @digits_string.length

    @digits_string
      .chars
      .each_cons(size)
      .map(&:join)
  end
end
