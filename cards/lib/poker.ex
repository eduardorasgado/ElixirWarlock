
defmodule Poker do
    def create_deck do
        values = [ "Ace", "Two", "Three", "Four", "Five", "King" ]
        suits = [ "Spades", "Clubs", "hearts" ,"Diamonds" ]

        for value <- values, suit <- suits do
            "#{value} of #{suit}"
        end
    end

    def shuffle_deck(deck) do
        Enum.shuffle(deck)
    end

    def contains?(deck, hand) do
        Enum.member?(deck, hand)
    end

    def deal(deck, hand_size) do
        { hand, rest_of_deck } =  Enum.split(deck, hand_size)
        hand
    end
end