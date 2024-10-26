class EliudsEggs
  def self.egg_count(int)
    int
      .to_s(2)
      .count('1')
  end
end
