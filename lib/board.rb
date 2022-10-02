# frozen_string_literal: true

require_relative 'display'

# board class for Connect Four game
class Board
  include Display
  attr_reader :board
  attr_accessor :last_move

  def initialize
    @board = Array.new(6) { Array.new(7, '-') }
    @last_move = nil
  end

  def display
    display_board(board)
  end

  def valid_column?(choice)
    (0..6).include?(choice) && !full?(column(choice))
  end

  def update(column_number, symbol)
    5.downto(0) do |row_number|
      if board[row_number][column_number] == '-'
        board[row_number][column_number] = symbol
        @last_move = [row_number, column_number]
        break
      end
    end
  end

  def full?(array = board)
    !array.flatten.include?('-')
  end

  def win?(symbol)
    lines = create_lines
    check_lines(lines, symbol)
  end

  private

  def create_lines(row_number = last_move[0], column_number = last_move[1])
    lines = []
    lines << row(row_number)
    lines << column(column_number)
    lines << upward_diagonal(row_number, column_number)
    lines << downward_diagonal(row_number, column_number)
  end

  def row(row_number)
    board[row_number]
  end

  def column(column_number, result = [])
    board.each { |row| result << row[column_number]}
    result
  end

  def upward_diagonal(row_number, column_number, result = [])
    until row_number == 5 || column_number == 0
      row_number += 1
      column_number -= 1
    end
    until row_number < 0 || column_number > 6
      result << board[row_number][column_number]
      row_number -= 1
      column_number += 1
    end
    result
  end

  def downward_diagonal(row_number, column_number, result = [])
    until row_number == 0 || column_number == 0
      row_number -= 1
      column_number -= 1
    end
    until row_number > 5 || column_number > 6
      result << board[row_number][column_number]
      row_number += 1
      column_number += 1
    end
    result
  end

  def check_lines(lines, symbol)
    lines.each do |line|
      count = 0
      line.each do |square|
        square == symbol ? count += 1 : count = 0
        return true if count == 4
      end
    end
    false
  end
end
