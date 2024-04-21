module Blackjack
  CARDS = { 'joker' => 0, 'ace' => 11, 'two' => 2, 'three' => 3, 'four' => 4, 'five' => 5, 'six' => 6, 'seven' => 7, 'eight' => 8,
            'nine' => 9, 'ten' => 10, 'jack' => 10, 'queen' => 10, 'king' => 10 }

  def self.parse_card(card)
    CARDS[card]
  end

  def self.card_range(card1, card2)
    score = parse_card(card1) + parse_card(card2)

    case score
    when 4..11
      'low'
    when 12..16
      'mid'
    when 17..20
      'high'
    else
      'blackjack'
    end
  end

  def self.first_turn(card1, card2, dealer_card)
    score = parse_card(card1) + parse_card(card2)

    case score
    when 22
      'P'
    when 21
      [10, 11].include?(parse_card(dealer_card)) ? 'S' : 'W'
    when 17..20
      'S'
    when 12..16
      parse_card(dealer_card) >= 7 ? 'H' : 'S'
    else
      'H'
    end
  end
end
