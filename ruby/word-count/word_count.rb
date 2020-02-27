=begin
Write your code for the 'Word Count' exercise in this file. Make the tests in
`word_count_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/word-count` directory.
=end

class Phrase
  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    @phrase
      .downcase
      .scan(/\b[\w']+\b/)
      .reject(&:empty?)
      .each_with_object(Hash.new(0)) do |word, hash|
        hash[word] += 1
      end
  end
end
