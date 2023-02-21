require 'spec_helper'

RSpec.describe do

  describe "start of the game" do
    it 'exists' do
      game = Game.new
      expect(game).to be_a(Game)
      game.start
    end
    xit 'says Welcome to Battleship' do
      game = Game.new
      # require 'pry'; binding.pry
      game.start
    end
  end
end