class Cell
attr_reader :coordinate,
            :ship,
            :fired_upon

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
  
  def fire_upon
    if @fired_upon == false && self.empty?
      @fired_upon = true
    elsif @fired_upon == false && self.empty? == false
      @ship.hit
      @fired_upon = true
    else
      false
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render(variable = false)
    if @fired_upon == true && self.empty? == false && @ship.health > 0
      "H"
    elsif @fired_upon == true && self.empty? == false && @ship.health <= 0
      "X"
    elsif variable == true && self.empty? == false && @fired_upon == false
      "S"
    elsif @fired_upon == true && self.empty? 
      "M" 
    elsif variable == true && self.empty?
      "."
    elsif @fired_upon == false
      "."
    else 
      "?"
    end
  end
end