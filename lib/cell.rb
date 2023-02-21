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
      false
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render(variable = nil)
    if self.fired_upon? && self.empty? == false && self.ship.sunk?
      p "X"
    elsif self.fired_upon? && self.empty? == false && @ship.sunk? == false
      p "H"
    elsif self.fired_upon? && self.empty? 
      p "M" 
    elsif variable && self.empty? == false
      p "S"
    elsif variable && self.empty?
      p "."
    else self.fired_upon? == false
      p "."
    end
    # if !variable.empty? 
    #   if ship.sunk?
    #     p "X"
    #   elsif self.empty? == true
    #     p "H"
    #   elsif 
    #     p "S"
    #   else
    #     p "."
    # else 
    #   if
  end
end