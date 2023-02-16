require './spec/spec_helper'


RSpec.describe Cell do

  describe '#initialize' do
    it 'can initialize' do
      cell = Cell.new("B4")
      
      expect(cell).to be_a(Cell)
    end
  end
  
  describe 'has proper attributes' do
    it 'has correct coordinate' do
      cell = Cell.new("B4")

      expect(cell.coordinate).to eq("B4")
    end

    it 'has no ship' do
      cell = Cell.new("B4")

      expect(cell.ship).to eq(nil)
    end

    it 'has empty? method defaulted to true' do
      cell = Cell.new("B4")

      expect(cell.empty?).to eq(true)
    end
  end

  describe 'can place ship' do
    it 'can place ship' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.ship).to eq(cruiser)
    end

    it 'can change #empty? to false' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.empty?).to eq(false)
    end
  end
end






