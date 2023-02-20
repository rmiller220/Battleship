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
    heading = "  1 2 3 4 \n"
    ("A".."D").each do |letter|
      heading += "#{letter} "
      (1..4).each do |number|
        coordinate = letter + number.to_s
        cell = @cells[coordinate]
        heading += cell.render(variable)
        heading += " "
      end
      heading += "\n"
    end
    heading
  end
end