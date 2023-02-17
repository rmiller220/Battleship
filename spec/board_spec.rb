require './spec/spec_helper'

RSpec.describe Board do

  describe '#initialize' do
    it 'exists' do
      board = Board.new
      
      expect(board).to be_a(Board)
    end
  end
  
  describe 'has proper attributes' do
    xit 'has cells' do
      board = Board.new
      require 'pry'; binding.pry
      expect(board.cells).to eq({})## havent figure out how to set this up yet
    #I think we might not need to actually write a test for it. 
    #Im not sure. my brain is fried right now
    end
  end
  
  describe 'valid coordinate?' do
    xit 'checks if coordinate is valid or not' do
      board = Board.new

      expect(board.valid_coordinate?('A1')).to eq(true)
      expect(board.valid_coordinate?('D4')).to eq(true)
      expect(board.valid_coordinate?('A5')).to eq(false)
      expect(board.valid_coordinate?('E1')).to eq(false)
      expect(board.valid_coordinate?('A22')).to eq(false)
    end
  end

  describe 'valid placement?' do
    xit 'checks ship placement is not valid based on size' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ['A1', 'A2'])).to eq(false)
      expect(board.valid_placement?(submarine, ['A2', 'A3', 'A4'])).to eq(false)
    end
    
    xit 'checks ship placement is not valid without consecutive coordinates' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be(false)
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to be(false)
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be(false)
      expect(board.valid_placement?(submarine, ["C1", "B1"])).to be(false)
    end

    xit 'checks ship placement not valid diagonally' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be(false)
      expect(board.valid_placement?(submarine, ["C2", "D3"])).to be(false)
    end
  end
end