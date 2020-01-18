defmodule Cards do
  @moduledoc """
  This module is for playing a card game
  """

  @doc """
  function that returns the complete deck
  """
  def create_deck do
    # creating an array of strings
    [ "Ace", "Two", "Three" ];
  end

  @doc """
   function that returns a shuffled deck randomly
  """
  def shuffle_deck(deck) do
    # using elixir standard library
    Enum.shuffle(deck);
  end

  @doc """
  function that returns if a deck contains a card

  finishing a function with ? question mark means that
  this function will return a boolean
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end
end
