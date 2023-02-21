class Cell
attr_reader :coordinate,
            :ship
attr_accessor :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    if @ship == nil
      true
    else
      false
    end
  end

  def place_ship(ship)
    if self.empty? == true
      @ship = ship
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

  def fired_upon?
      @fired_upon
  end

  def render(variable = nil)
    if variable && self.empty?
      p "."
    elsif self.fired_upon? && self.empty? 
      p "M" 
    elsif self.fired_upon? && self.empty? == false && ship.sunk? == false
      p "H"
    elsif self.fired_upon? && self.empty? == false && ship.sunk?
      p "X"
    elsif variable && self.empty? == false
      p "S"
    else self.fired_upon? == false
      p "."
    end
  end
end