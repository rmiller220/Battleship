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

  # def valid_placement?(ship, coordinates)
  #   consecutive_row = coordinates.each_cons(2).any? { |a,b| a.ord - b.ord == 0}
  #   consecutive_column = coordinates.each_cons(2).any? { |a,b| a.ord - b.ord == 1}
  #   if coordinates.length == ship.length && consecutive_row == true
  #     coordinates.each do |coordinate|
  #       @cells["#{coordinate}"] = ship
  #     end
  #     true
  #   elsif coordinates.length == ship.length && consecutive_column == true
  #     coordinates.each do |coordinate|
  #       @cells["#{coordinate}"] = ship
  #     end
  #     true
  #   else
  #     false
  #   end
  # end

  def valid_placement?(ship, coordinates)
    @split = []
    @split_values = []
    coordinates.each { |coord| @split << coord.split("") }
    @split.each do |split| 
      @split_values << (split.first.ord + split.last.ord)
    end

    if coordinates.length == ship.length && @split_values.each_cons(2).all? { |a,b| a.ord - b.ord == -1} == true
      true
    else
      false
    end
  end

end