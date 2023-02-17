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
    @split = []
    @split_values = []
    coordinates.each { |coord| @split << coord.split("") }
    @split.each { |split| @split_values << (split.first.ord + split.last.ord) }
    coordinates.each { |coordinate| @empty_ceck = @cells[coordinate].empty? }
  
    if coordinates.length == ship.length && @split_values.each_cons(2).all? { |a,b| a.ord - b.ord == -1} == true && @empty_check == true
      true
    else
      false
    end
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end


end