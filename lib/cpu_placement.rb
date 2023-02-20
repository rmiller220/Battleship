require './lib/ship'
require './lib/board'

class CpuPlacement
  attr_reader :board,
              :ship
  attr_accessor :coordinates
 

  def initialize(ship, board)
    @ship = ship 
    @board = board
  end

  def cpu_placement
    coordinate_array = []
      ("A".."D").each do |letter|
        (1..4).each do |number|
          coordinate = letter + number.to_s
          coordinate_array << coordinate
        end
      end
    @coordinates = coordinate_array.sample(@ship.length) 
    @coordinates = coordinate_array.sample(@ship.length) until (board.valid_placement?(@ship, @coordinates)) == true
    board.valid_placement?(@ship, @coordinates)
  end
end
