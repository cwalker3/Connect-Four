# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }
  describe '#initialize' do
    it 'creates a nested array of 6 arrays of size 7' do
      expected_board = [
        ['-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-']
      ]
      expect(board.board).to eq(expected_board)
    end
  end

  describe 'valid_column?' do
    it 'returns false when choice is greater than 6' do
      expect(board.valid_column?(8)).to eq(false)
    end
    it 'returns false when choice is less than 0' do
      expect(board.valid_column?(-1)).to eq(false)
    end
    it 'returns false when choice is between 0 and 6 but the column is full' do
      allow(board).to receive(:full?).and_return(true)
      expect(board.valid_column?(1)).to eq(false)
    end
    it 'returns true when choice is between 0 and 6 and column is not full' do
      allow(board).to receive(:full?).and_return(false)
      expect(board.valid_column?(1)).to eq(true)
    end
  end

  describe '#update' do
    context 'when choice is column 0, and column 0 is empty' do
      it 'places the symbol at the bottom of column 1' do
        board.instance_variable_set(:@board, [
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-']])
        board.update(0, 'X')
        expect(board.board).to eq([
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['X', '-', '-', '-', '-', '-', '-']])
      end
    end
    context 'when choice is column 7 and column 7 has 1 slot empty' do
      it 'places the symbol at the top of column 7' do
        board.instance_variable_set(:@board, [
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', 'X'],
          ['-', '-', '-', '-', '-', '-', 'O'],
          ['-', '-', '-', '-', '-', '-', 'X'],
          ['-', '-', '-', '-', '-', '-', 'O'],
          ['-', '-', '-', '-', '-', '-', 'X']])
        board.update(6, 'O')
        expect(board.board).to eq([
          ['-', '-', '-', '-', '-', '-', 'O'],
          ['-', '-', '-', '-', '-', '-', 'X'],
          ['-', '-', '-', '-', '-', '-', 'O'],
          ['-', '-', '-', '-', '-', '-', 'X'],
          ['-', '-', '-', '-', '-', '-', 'O'],
          ['-', '-', '-', '-', '-', '-', 'X']])
      end
    end
  end

  describe '#full' do
    it 'returns true when the array does not contain "-"' do
      array = [1, 2, 3, 4]
      expect(board.full?(array)).to eq(true)
    end

    it 'returns false when the array contains "-"' do
      array = ['-', '-', '-', '-', '-', '-', '-']
      expect(board.full?(array)).to eq(false)
    end
    it 'works for a nested array' do
      array = [[1, 2, 3], [4, 5, 6], [7, 8, '-']]
      expect(board.full?(array)).to eq(false)
    end
  end

  describe '#win?' do
    it 'returns false when there is no winning line' do
      board.instance_variable_set(:@board, [
        ['X', '-', '-', '-', '-', '-', '-'],
        ['X', '-', '-', '-', '-', '-', '-'],
        ['C', '-', '-', '-', '-', '-', 'C'],
        ['X', '-', '-', '-', '-', 'X', 'C'],
        ['X', '-', '-', '-', 'X', 'X', 'C'],
        ['X', 'C', 'C', 'X', 'C', 'X', 'X']])
      board.instance_variable_set(:@last_move, [0,0])
      expect(board.win?('X')).to eq(false)
    end
    it 'returns true when there is winning upwards diagonal line' do
      board.instance_variable_set(:@board, [
        ['-', '-', '-', '-', '-', '-', 'O'],
        ['-', '-', '-', '-', '-', '-', 'O'],
        ['-', '-', '-', '-', 'O', '-', 'X'],
        ['-', '-', '-', 'O', 'X', '-', 'X'],
        ['-', '-', 'O', 'O', 'O', '-', 'O'],
        ['-', 'O', 'O', 'O', 'X', '-', 'X']])
      board.instance_variable_set(:@last_move, [2, 4])
      expect(board.win?('O')).to eq(true)
    end
    it 'returns true when there is a winning downwards diagonal line' do
      board.instance_variable_set(:@board, [
        ['-', '-', '-', 'q', '-', '-', '-'],
        ['-', '-', '-', '-', 'q', '-', '-'],
        ['-', '-', '-', '-', '-', 'q', '-'],
        ['-', '-', '-', '-', '-', '-', 'q'],
        ['-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-']])
      board.instance_variable_set(:@last_move, [1, 4])
      expect(board.win?('q')).to eq(true)
    end
    it 'returns true when there is a winning  column' do
      board.instance_variable_set(:@board, [
        ['-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-'],
        ['-', 'e', '-', '-', '-', '-', '-'],
        ['-', 'e', '-', '-', '-', '-', '-'],
        ['-', 'e', '-', '-', '-', '-', '-'],
        ['-', 'e', '-', '-', '-', '-', '-']])
      board.instance_variable_set(:@last_move, [2, 1])
      expect(board.win?('e')).to eq(true)
    end
    it 'returns true when there is a winning row' do
      board.instance_variable_set(:@board, [
        ['-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-'],
        ['-', 'x', 'x', 'x', 'x', 'x', '-'],
        ['-', 'x', 'o', 'o', 'o', 'x', '-']])
      board.instance_variable_set(:@last_move, [4, 4])
      expect(board.win?('x')).to eq(true)
    end
  end
end
