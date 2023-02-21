require './spec/spec_helper'

RSpec.describe do
  describe 'turn class exists' do
    it 'exits' do
      turn = Turn.new

      expect(turn).to be_a(Turn)
    end
  end
    it 'starts a game and a turn' do
      game = Game.new
      turn = Turn.new
      game.start
    end

end