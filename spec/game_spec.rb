# frozen_string_literal: true

require_relative '../lib/game'

RSpec.describe Game do
  let(:board) { double(Board) }
  let(:player1) { double('player', name: 'John', symbol: 'X') }
  let(:player2) { double('player', name: 'Adam', symbol: 'O') }

  subject(:game) { described_class.new(board, player1, player2) }

  describe '#next_player' do
    it 'returns player 2 when current player is player 1' do
      game.current_player = game.player1
      player = game.next_player
      expect(player).to eq(game.player2)
    end
    it 'returns player 1 when current player is player 2' do
      game.current_player = game.player2
      player = game.next_player
      expect(player).to eq(game.player1)
    end
  end

  describe '#game_over?' do
    it 'returns false when board is not full and game is not won' do
      allow(board).to receive(:full?).and_return(false)
      allow(board).to receive(:win?).and_return(false)
      expect(game.game_over?).to eq(false)
    end
    it 'returns true when board is full' do
      allow(board).to receive(:full?).and_return(true)
      allow(board).to receive(:win?)
      expect(game.game_over?).to eq(true)
    end
    it 'returns true when game is won' do
      allow(board).to receive(:full?)
      allow(board).to receive(:win?).and_return(true)
      expect(game.game_over?).to eq(true)
    end
  end

  describe '#play_again?' do
    it 'returns true when input is y' do
      allow(game).to receive(:gets).and_return('y')
      expect(game.play_again?).to eq(true)
    end

    it 'returns false when input is not y' do
      allow(game).to receive(:gets).and_return('z')
      expect(game.play_again?).to eq(false)
    end
  end
end
