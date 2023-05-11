module Acronym
  def self.abbreviate(phrase : String) : String
    phrase.split(/[\s\-_]/, remove_empty: true)
      .map(&.chars.first)
      .join
      .upcase
  end
end
