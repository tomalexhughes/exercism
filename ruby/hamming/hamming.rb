class Hamming
  def self.compute(a, b)
    raise ArgumentError if a.length != b.length

    a.chars.map.with_index { |ch, idx| ch != b.chars[idx] }.filter { |bool| bool }.length
  end
end
