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
    @ship = ship
  end
  
  def fire_upon
    if @fired_upon == false
      @fired_upon = true
      @ship.hit
    else
      p "Can't fire"
    end
  end

  def fired_upon?
    @fired_upon
  end
end