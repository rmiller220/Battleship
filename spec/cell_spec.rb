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

      expect(cell.render).to eq(".")
    end
  end
end


# cell_1.fire_upon

# cell_1.render
# # => "M"

# cell_2 = Cell.new("C3")
# # => #<Cell:0x00007f84f0b29d10...>

# cruiser = Ship.new("Cruiser", 3)
# # => #<Ship:0x00007f84f0ad4fb8...>

# cell_2.place_ship(cruiser)

# cell_2.render
# # => "."

# # Indicate that we want to show a ship with the optional argument
# cell_2.render(true)
# # => "S"

# cell_2.fire_upon

# cell_2.render
# # => "H"

# cruiser.sunk?
# # => false

# cruiser.hit

# cruiser.hit

# cruiser.sunk?
# # => true

# cell_2.render
# # => "X"




