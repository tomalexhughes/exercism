class Hamming
  def self.compute(a, b)
    raise ArgumentError if a.length != b.length

    a.chars.zip(b.chars).count { |x, y| x != y }
  end
end
