class Scrabble
  attr_reader :word

  MAP = { 1 => 'AEIOULNRST', 2 => 'DG', 3 => 'BCMP', 4 => 'FHVWY', 5 => 'K', 8 => 'JX', 10 => 'QZ' }.freeze

  def initialize(word)
    @word = word
  end

  def score
    return 0 if @word.nil? || @word.strip.empty?

    word.upcase.chars.map { |char| MAP.find { |_key, values| values.include?(char) }.first }.sum
  end

  def self.score(word)
    Scrabble.new(word).score
  end
end
