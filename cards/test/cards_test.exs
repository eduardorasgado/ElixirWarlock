defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck creates 24 different cards" do
    deck_length = length Cards.create_deck
    # assert is used to prove if something actually is true
    assert deck_length == 24
  end

  test "shuffling correctly a deck randomizes it" do
    deck = Cards.create_deck
    #refute is special keyword to return true is something
    # result the inverse
    refute deck == Cards.shuffle_deck deck
  end

  test "contains return true if given existing card inside deck" do
    deck = Cards.create_deck
    # list pattern matching
    [ _card1, card2, _card3 | _rest ] = deck
    assert :true == Cards.contains?(deck, card2)
  end

  test "if deal returns a list of 12 elements" do
    handsize =12
    hand = Cards.create_deck 
    |> Cards.shuffle_deck 
    |> Cards.deal(handsize)

    assert length(hand) == handsize
  end

  test "if create_hand returns a list of 12 elements" do
    handsize =12
    
    hand = Cards.create_hand(handsize)
    assert length(hand) == handsize
  end

  test "if read returns error message in case we give a non existing name to it" do
    filename = "no_existing_name"
    assert is_bitstring(Cards.read(filename)) 
  end

  test "if read returns a list in case we give a non existing name to it" do
    filename = "Bunch_of_cards"
    assert is_list(Cards.read(filename)) 
  end

end
