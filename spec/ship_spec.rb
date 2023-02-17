require './spec/spec_helper'


RSpec.describe Ship do

  describe '#initialize' do
    it 'can initialize' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser).to be_a(Ship)
    end

    it 'has correct attributes' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser.name).to eq("Cruiser")
      expect(cruiser.length).to eq(3)
      expect(cruiser.health).to eq(3)
    end

    it '#sunk? menthod defaults to false' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser.sunk?).to eq(false)
    end

    it 'can register #hit to health' do
      cruiser = Ship.new("Cruiser", 3)
      cruiser.hit

      expect(cruiser.health).to eq(2)

      cruiser.hit

      expect(cruiser.health).to eq(1)
      expect(cruiser.sunk?).to eq(false)
    end

    it 'can sink ship' do
      cruiser = Ship.new("Cruiser", 3)
      cruiser.hit
      cruiser.hit
      cruiser.hit

      expect(cruiser.health).to eq(0)
      expect(cruiser.sunk?).to eq(true)
    end
  end
end

