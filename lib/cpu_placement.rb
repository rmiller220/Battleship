require './lib/ship'
require './lib/board'

class CpuPlacement
  attr_reader :board,
              :ship

  def initialize(ship, board)
    @ship = ship 
    @board = board
    @coordinates = []
  end

  
end