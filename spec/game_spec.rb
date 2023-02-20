require 'spec_helper'

RSpec.describe do

  describe "start of the game" do
    it 'exists' do
      game = Game.new(Board.new, Board.new)
      
      expect(game).to be_a(Game)
    require 'pry'; binding.pry
    end
    xit 'says Welcome to Battleship' do
      game = Game.new

      expect(game.start).to eq("Welcome to BATTLESHIP Enter p to play. Enter q to quit")
    end
  end
end