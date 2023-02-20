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

  def cpu_placement
    @coordinate_array = []
      ("A".."D").each do |letter|
        (1..4).each do |number|
          coordinate = letter + number.to_s
          @coordinate_array << coordinate
        end
      end
    until  (board.valid_placement?(@ship, @coordinates)) == true
      @coordinates = @coordinate_array.sample(@ship.length)
    end
    @coordinates
  end
end