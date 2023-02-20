require './spec/spec_helper'

RSpec.describe CpuPlacement do

  describe 'can #generate_coordinates' do
    it 'can generate valid coordinates and place ship' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    cruiser_placement = CpuPlacement.new(cruiser, board)

    expect(cruiser_placement.cpu_placement).to eq(true)
    end
  end
end