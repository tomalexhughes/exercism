class DndCharacter
  attr_reader :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, :hitpoints

  def self.modifier(constitution)
    ((constitution - 10) / 2).to_i
  end

  def initialize
    @strength = roll
    @dexterity = roll
    @constitution = roll
    @intelligence = roll
    @wisdom = roll
    @charisma = roll
    @hitpoints = 10 + DndCharacter.modifier(@constitution)
  end

  private

  def roll
    Array.new(4) { rand(1..6) }
         .sort
         .reverse
         .take(3)
         .sum
  end
end
