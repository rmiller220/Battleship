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
    @empty_check = false
  end

  def valid_coordinate?(coordinate)
    @cells.key?"#{coordinate}"
  end

  def valid_placement?(ship, coordinates)
    @split = []
    @split_values = []
    @boolean_array = []
    coordinates.each { |coord| @split << coord.split("") }
    @split.each { |split| @split_values << (split.first.ord + split.last.ord) }
    coordinates.each { |coordinate| @boolean_array << @cells[coordinate].empty? }
    
    if coordinates.length == ship.length && @split_values.each_cons(2).all? { |a,b| a.ord - b.ord == -1} == true && @boolean_array.include?(false) == false
      true
    else
      false
    end
  end

  def place(ship, coordinates)
    @boolean_array = []
    coordinates.each { |coordinate| @boolean_array << @cells[coordinate].empty? }
    if !@boolean_array.include?(false) 
        coordinates.each do |coordinate|
          @cells[coordinate].place_ship(ship)
        end
      true
    else
      false
    end
  end
  def fired_upon?
    @fired_upon
  end
  def fire_upon #I had to refactor this to accomodate the render method
    if @fired_upon == false && self.empty?
      @fired_upon = true
    elsif @fired_upon == false && self.empty? == false
      @fired_upon = true
      @ship.hit
    else
      p "Can't fire"
    end
  end
  def render(variable = nil)
    cells_rendered = []
    self.cells.each do |cell|
      cells_rendered << cell.render
    end
    cells_rendered.to_s
    # if variable && self.empty? == false
    #   p "S"
    # elsif variable && self.empty?
    #   p "."
    # elsif self.fired_upon? && self.empty? 
    #   p "M" 
    # elsif self.fired_upon? && self.empty? == false && ship.sunk? == false
    #   p "H"
    # elsif self.fired_upon? && self.empty? == false && ship.sunk?
    #   p "X"
    # else self.fired_upon? == false
    #   p "."
    # end
  end
end