class Luhn
  def self.valid?(input)
    input = input.gsub(' ', '')

    return false if /\D/.match(input)
    return false if input.length <= 1

    input
      .chars
      .reverse
      .map.with_index { |d, i| i.odd? ? d.to_i * 2 : d.to_i }
      .map { |d| d > 9 ? d - 9 : d } # We know if it's > 9 it's the result of our doubling
      .sum
      .modulo(10)
      .zero?
  end
end

