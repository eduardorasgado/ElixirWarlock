defmodule Cards do
  @moduledoc """
  This module is for playing a card game

  run 
    mix docs
  to be able to get project documentation, we had to add ex_doc dependency
  on mix.exs
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

  Pattern matching: Elixir replacement for variable assignment

  The `deck` arguments is a list of cards preferable shuffled before.
  The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> hand = Cards.deal(deck, 2)
      iex> hand
      ["Ace of Spades", "Two of Spades"]

  """
  def deal(deck, hand_size) do
    # return a tuple, yes tuples exist in elixir in {} curly braces shape
    #a tuple start on 0
    # in this case hand returns in position 0
    # pattern matching used to take deck from tuple resulted from splitting
    # right is a tuple so left should be a tuple
    { hand, _rest_of_deck } = Enum.split(deck, hand_size)
    hand    
  end

  @doc """
  Write out our current deck in file system

  The `filename` argument indicates the name user will use to access again
  to the deck resource.
  """
  def save(deck, filename) do
    # erlang object here is built in erlang method, to execute erlang code
    # in non erlang environment
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Method to read a binary saved deck
  """
  def read(filename) do
    #{ status, binary } = File.read filename
    
    # error handling using case statement
    case File.read filename do
      # this is the same that .binary_to_term(binary)
      { :ok, binary } -> :erlang.binary_to_term binary
      # use underscore when a variable in pattern matching left side wont be
      # used in next operations
      { :error, _reason } -> 
        "No file with file name: #{filename} does not exists."
    end
  end

  @doc """
  Returns a hand created by shuffleing a created deck and splitting it
  """
  def create_hand(hand_size) do
    # using pipe operator to avoid variable creation and code simplification
    Cards.create_deck 
    |> Cards.shuffle_deck() 
    |> Cards.deal(hand_size)
  end
end
