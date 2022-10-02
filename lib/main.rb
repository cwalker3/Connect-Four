# frozen_string_literal: true

require_relative 'game'
require_relative 'board'
require_relative 'display'

def play_game(game)
  game_loop(game)
  system 'clear'
  game.board.display
  game.finish
end

def game_loop(game)
  loop do
    system 'clear'
    game.board.display
    column_number = game.valid_player_choice
    game.board.update(column_number, game.current_player.symbol)
    break if game.game_over?

    game.next_player
  end
end

def introduction
  puts <<~HEREDOC
    Welcome to Connect Four!
    The goal of this game is to connect 4 symbols in a straight line in any direction.
    Each player will take turns choosing a slot to drop a symbol in.

  HEREDOC
end

loop do
  system 'clear'
  introduction
  game = Game.new
  play_game(game)
  break unless game.play_again?
end
