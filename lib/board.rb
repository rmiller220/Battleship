class Board
  attr_reader :cells

  def initialize
    @cells = {}
    ("A".."D").each do |letter|
      (1..4).each do |number|
        coordinate = letter + number.to_s
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells.key?"#{coordinate}"
  end

  def valid_placement?(ship, coordinates)
    if coordinates.length == ship.length && #need to validate consecutive
    end
  end
end