module Blackjack

  STAND = 'S'
  HIT   = 'H'
  SPLIT = 'P'
  WIN   = 'W'
  private_constant :STAND, :HIT, :SPLIT, :WIN

  class Card

    attr_accessor :name

    VALUES = {
      'ace'   => 11, 'two'   => 2,  'three' => 3,
      'four'  => 4,  'five'  => 5,  'six'   => 6,
      'seven' => 7,  'eight' => 8,  'nine'  => 9,
      'ten'   => 10, 'jack'  => 10, 'queen' => 10,
      'king'  => 10, 'joker' => 0
    }

    def initialize(name)= self.name = name

    def value() = VALUES[name]

    def +(other)
      case other
      when Card then Hand.new([self, other])
      when Hand then Hand.new([self] + other.cards)
      else Hand.new([self, other])
      end
    end

    def to_s()= name

  end

  class Hand

    attr_accessor :cards

    def initialize(cards=[])= self.cards = cards

    def +(other)
      case other
      when Card then Hand.new(cards + [other])
      when Hand then Hand.new(cards + other.cards)
      else Hand.new(cards + [other])
      end
    end

    def total()= cards.sum(&:value)

    def blackjack?()= cards.size == 2 && total == 21

    def pair_of_aces?()= cards.size == 2 &&
      cards.all? { |card| card.name == 'ace' }

    def to_s()= cards.map(&:to_s).join(', ')

  end

  def self.parse_card(card_name)
    Card.new(card_name).value
  end

  def self.card_range(card1_name, card2_name)
    card1 = Card.new(card1_name)
    card2 = Card.new(card2_name)
    hand = card1 + card2
    total = hand.total

    case total
    when 4..11  then 'low'
    when 12..16 then 'mid'
    when 17..20 then 'high'
    when 21     then 'blackjack'
    end
  end

  def self.first_turn(card1_name, card2_name, dealer_card_name)
    card1  = Card.new(card1_name)
    card2  = Card.new(card2_name)
    dealer = Card.new(dealer_card_name)
    player_hand = card1 + card2
    hand_total = player_hand.total
    dealer_value = dealer.value

  return 'P' if player_hand.pair_of_aces?
  return dealer_value >= 10 ? STAND : WIN if player_hand.blackjack?
  return STAND if hand_total >= 17 && hand_total <= 20
  return dealer_value >= 7 ? HIT : STAND if
    hand_total >= 12 && hand_total <= 16
  return HIT if hand_total <= 11

    HIT
  end

end
