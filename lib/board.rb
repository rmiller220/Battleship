class Board
  attr_reader :cells,
              :coordinate_array, 
              :ship,
              :row,
              :column

  def initialize(row = "D", column = 4)
    @cells = {}
    @ship = []
    @coordinate_array = []
    @row = row
    @column = column
    ("A"..@row).each do |letter|
      (1..@column).each do |number|
        coordinate = letter + number.to_s
        @coordinate_array << coordinate
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
    
    if coordinates.length == ship.length && consecutive_check(ship, coordinates) == true && @boolean_array.all?(true)
      valid = true
    else
      valid = false
    end
    valid
  end

  def place(ship, coordinates)
    @boolean_array = []
    coordinates.each { |coordinate| @boolean_array << @cells[coordinate].empty? }
    if !@boolean_array.include?(false) 
        coordinates.each do |coordinate|
          @cells[coordinate].place_ship(ship)
        end
      @ship << ship
      true
    else
      false
    end
  end
  
  def render(variable = false)
    heading = "  1 2 3 4 \n"
    ("A"..@row).each do |letter|
      heading += "#{letter} "
      (1..@column).each do |number|
        coordinate = letter + number.to_s
        cell = @cells[coordinate]
        heading += cell.render(variable)
        heading += " "
      end
      heading += "\n"
    end
    print heading
    heading
  end

  def consecutive_check(ship, coordinates)
    valid = false
    @first_values = []
    @last_values = []
    @split = []
    @split_values = []
    coordinates.each { |coord| @split << coord.split("") }
    @split.each { |split| @first_values << (split.first.ord) }
    @split.each { |split| @last_values << (split.last.ord) }
    coordinates.each do |coordinate|
      if ship.length == 3
        if @first_values.each_cons(3).all? { |a,b,c| a.ord - b.ord == 0 && b.ord - c.ord == 0} && @last_values.each_cons(3).all? { |a,b,c| a.ord - b.ord == -1 && b.ord - c.ord == -1} 
          valid = true
        elsif @first_values.each_cons(3).all? { |a,b,c| a.ord - b.ord == -1 && b.ord - c.ord == -1 } && @last_values.each_cons(3).all? { |a,b,c| a.ord - b.ord == 0 && b.ord - c.ord == 0} 
          valid = true
        else
          valid = false
        end
      elsif ship.length == 2
        if @first_values.each_cons(2).all? { |a,b| a.ord - b.ord == 0 } && @last_values.each_cons(2).all? { |a,b| a.ord - b.ord == -1 } 
        valid = true
        elsif @first_values.each_cons(2).all? { |a,b| a.ord - b.ord == -1 } && @last_values.each_cons(2).all? { |a,b| a.ord - b.ord == 0 } 
          valid = true
        else
          valid = false
        end
      else
        valid = false
      end
    end
    valid
  end

  def coordinate_shuffle
    @coordinate_array.shuffle!
  end
end