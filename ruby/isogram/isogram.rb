class Isogram
  def self.isogram?(input)
    letters = input.downcase.gsub(/[^a-z]/, '')
    letters.chars.length == letters.chars.uniq.length
  end
end
