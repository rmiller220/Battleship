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

  describe 'has working #fired_upon method' do
    it 'has #fired_upon default to false' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    expect(cell.fired_upon?).to eq(false)
    end

    it 'can be #fired_upon' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      cell.fire_upon

      expect(cell.fired_upon?).to eq(true)
      expect(cell.ship.health).to eq(2)
    end
  end

  describe 'has working #render method' do
    it 'defaults #render to . ' do
      cell_1 = Cell.new("B4")
      
      expect(cell_1.render).to eq(".")
    end

    it 'checks render if miss to be M' do 
      cell_1 = Cell.new("B4")
      cell_1.fire_upon

      expect(cell_1.render).to eq("M")
    end

    it 'checks place ship with render to return .' do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      
      expect(cell_2.render).to eq('.')
    end

    it 'checks render with a hit to return H' do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      cell_2.fire_upon
  
      expect(cell_2.render).to eq("H")
    end
    it 'renders X if ship is sunk' do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      cell_2.fire_upon

      expect(cruiser.sunk?).to eq(false)

      cruiser.hit
      cruiser.hit
      
      expect(cruiser.sunk?).to eq(true)
      expect(cell_2.render).to eq("X")
    end
    #I moved these tests out of order to group it with similar method tests
    #Feel free to move it back in the correct order if you prefer that
  end
  
  describe 'optional render(true) method' do
    it 'checks render(true)' do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      
      expect(cell_2.render(true)).to eq("S")
    end
  end
end


# cruiser.sunk?
# # => false

# cruiser.hit

# cruiser.hit

# cruiser.sunk?
# # => true

# cell_2.render
# # => "X"




