defmodule Cards do
  @moduledoc """
  This module is for playing a card game
  """

  @doc """
  function that returns the complete deck
  """
  def create_deck do
    # creating an array of strings
    values = [ "Ace", "Two", "Three", "Four", "Five", "King" ]
    suits = [ "Spades", "Clubs", "Hearts", "Diamonds" ]

    #storing a couple of list comprehensions into a variable
    #FIRST WAY
    cards = 
    for value <- values do # creating a list comprehension
      # inner list comp.
      for suit <- suits do
        # this is a string concatenation
        "#{value} of #{suit}"
      end
    end
    # creating a list based on the given lists inside the function
    List.flatten(
      cards
    )

    #storing a couple of list comprehensions into a linear list
    #SECOND WAY
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
   function that returns a shuffled deck randomly
  """
  def shuffle_deck(deck) do
    # using elixir standard library
    Enum.shuffle(deck)
  end

  @doc """
  function that returns if a deck contains a card

  finishing a function with ? question mark means that
  this function will return a boolean
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
  Method to return a certain hand size deck
  """
  def deal(deck, hand_size) do
    # return a tuple, yes tuples exist in elixir in {} curly braces shape
    #a tuple start on 0
    # in this case hand returns in position 0
    Enum.split(deck, hand_size)
  end
end
