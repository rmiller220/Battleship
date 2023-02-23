require './spec/spec_helper'

RSpec.describe do
  describe 'turn class exists' do
    it 'exits' do
      player_board = Board.new
      cpu_board = Board.new
      turn = Turn.new(cpu_board, player_board)

      expect(turn).to be_a(Turn)
    end
  end

    it 'starts a game and a turn' do
      game = Game.new
      player_board = Board.new
      cpu_board = Board.new
      turn = Turn.new(cpu_board, player_board)
    end
end