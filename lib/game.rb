# frozen_string_literal: true

require_relative 'board'
require_relative 'display'

# Connect Four game class
class Game
  include Display
  attr_reader :board, :player1, :player2, :turn_number
  attr_accessor :current_player

  def initialize(board = Board.new, player1 = create_player(1), player2 = create_player(2))
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  Player = Struct.new(:name, :symbol)
  def create_player(number)
    name = player_name(number)
    symbol = player_symbol(name)
    Player.new(name, symbol)
  end

  def valid_player_choice
    choice = player_choice
    until board.valid_column?(choice)
      invalid_choice_message
      choice = player_choice
    end
    choice
  end

  def next_player
    @current_player = current_player == player1 ? player2 : player1
  end

  def game_over?
    board.full? || board.win?(current_player.symbol)
  end

  def finish
    if board.full?
      tie_game_message
    else
      player_win_message(current_player.name)
    end
    thank_you_message
  end

  def play_again?
    prompt_play_again
    gets.chomp.downcase == 'y'
  end

  private

  def player_name(number)
    prompt_player_name(number)
    name = gets.chomp
    until valid_name?(name)
      invalid_name_message
      name = gets.chomp
    end
    name
  end

  def valid_name?(name)
    !name.empty?
  end

  def player_symbol(name)
    prompt_player_symbol(name)
    symbol = gets.chomp
    until valid_symbol?(symbol)
      invalid_symbol_message
      symbol = gets.chomp
    end
    symbol
  end

  def valid_symbol?(symbol)
    symbol.length == 1 && symbol != '-'
  end

  def player_choice
    prompt_player_choice(current_player.name)
    gets.chomp.to_i - 1
  end
end
