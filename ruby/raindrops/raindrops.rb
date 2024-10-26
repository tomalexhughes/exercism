class Raindrops
  def self.convert(int)
    result = ''
    result += 'Pling' if int % 3 == 0
    result += 'Plang' if int % 5 == 0
    result += 'Plong' if int % 7 == 0

    return int.to_s if result.empty?

    result
  end
end
