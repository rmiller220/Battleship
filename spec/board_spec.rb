require './spec/spec_helper'

RSpec.describe Board do

  describe '#initialize' do
    it 'exists' do
      board = Board.new
      
      expect(board).to be_a(Board)
    end
  end
  
  describe 'valid coordinate?' do
    it 'checks if coordinate is valid or not' do
      board = Board.new

      expect(board.valid_coordinate?('A1')).to eq(true)
      expect(board.valid_coordinate?('D4')).to eq(true)
      expect(board.valid_coordinate?('A5')).to eq(false)
      expect(board.valid_coordinate?('E1')).to eq(false)
      expect(board.valid_coordinate?('A22')).to eq(false)
    end
  end

  describe 'valid placement?' do
    it 'checks ship placement is not valid based on size' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ['A1', 'A2'])).to eq(false)
      expect(board.valid_placement?(submarine, ['A2', 'A3', 'A4'])).to eq(false)
    end
    
    it 'checks ship placement is not valid without consecutive coordinates' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be(false)
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to be(false)
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be(false)
      expect(board.valid_placement?(submarine, ["C1", "B1"])).to be(false)
    end

    it 'checks ship placement not valid diagonally' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["D1", "D2", "C4"])).to be(false)
      expect(board.valid_placement?(submarine, ["C2", "D3"])).to be(false)
    end
  end

  describe 'placing ships' do
    it 'places ship on valid coordinates and checks ship' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"] 
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      expect(cell_1.ship).to eq(cruiser)
      expect(cell_2.ship).to eq(cruiser)
      expect(cell_3.ship).to eq(cruiser)
    end
    
    it 'checks overlapping placement of ships' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      
      expect(board.place(cruiser, ["A1", "A2", "A3"])).to be(true)
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to be(false)
      expect(board.place(submarine, ["A1", "B1"])).to be(false)
    end
  end
  
  describe 'render the board' do
    it 'checks the render method' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      require 'pry'; binding.pry
      expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end
    
    it 'checks the render method with variable' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      
      expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    end
  end

  describe 'checks hits and misses' do
    it 'checks for a hit on the board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      board.cells["A1"].fire_upon
      
      expect(board.render).to eq("  1 2 3 4 \nA H . . . \nB . . . . \nC . . . . \nD . . . . \n")

      board.cells["A2"].fire_upon
      board.cells["A3"].fire_upon

      expect(board.render).to eq("  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it 'can hit, miss, sunk show player board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      board.cells["A1"].fire_upon
      
      expect(board.render(true)).to eq("  1 2 3 4 \nA H S S . \nB . . . . \nC . . . . \nD . . . . \n")

      board.cells["A4"].fire_upon
      board.cells["A2"].fire_upon
      board.cells["A3"].fire_upon

      expect(board.render).to eq("  1 2 3 4 \nA X X X M \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it 'adds 2 ships, checks hit, miss, sunk' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      submarine = Ship.new("Submarine", 2)
      board.place(submarine, ["C3", "D3"])
      
      expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
      expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . S . \nD . . S . \n")
      
      board.cells["A1"].fire_upon
      board.cells["B1"].fire_upon
      board.cells["B3"].fire_upon
      board.cells["D1"].fire_upon
      board.cells["C3"].fire_upon
      board.cells["D4"].fire_upon
      board.cells["A4"].fire_upon
      board.cells["A2"].fire_upon
      board.cells["A3"].fire_upon
      
      expect(board.render).to eq("  1 2 3 4 \nA X X X M \nB M . M . \nC . . H . \nD M . . M \n")
      expect(board.render(true)).to eq("  1 2 3 4 \nA X X X M \nB M . M . \nC . . H . \nD M . S M \n")
    end
  end

end