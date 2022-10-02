# frozen_string_literal: true

# module containing display methods for Connect Four game
module Display
  def prompt_player_name(number)
    puts "\nPlayer #{number}, enter your name:"
  end

  def invalid_name_message
    puts 'Invalid name.'
  end

  def prompt_player_symbol(name)
    puts <<~HEREDOC

      Hello #{name}, please enter a symbol to use on the board.
      Your symbol must be 1 character and it cannot be \'-\'.
    HEREDOC
  end

  def invalid_symbol_message
    puts 'Invalid symbol.'
  end

  def prompt_player_choice(name)
    puts "#{name}, choose a slot (1-7) to drop your symbol in."
  end

  def invalid_choice_message
    puts 'Invalid choice.'
  end

  def display_board(board)
    board.each do |row|
      row.each { |slot| print "|#{slot}" }
      puts '|'
    end
    (1..7).each { |number| print " #{number}" }
    puts
  end

  def tie_game_message
    puts 'Tie game!'
  end

  def player_win_message(name)
    puts "#{name} wins!"
  end

  def thank_you_message
    puts 'Thank you for playing!'
  end

  def prompt_play_again
    puts 'Enter \'y\' to play again, or any other key to stop playing.'
  end
end
