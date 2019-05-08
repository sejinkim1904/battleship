class Cell
  attr_reader :coordinate, :ship, :empty, :fired_upon, :render

  def initialize(coordinate)
    @coordinate = coordinate
    @empty = true
    @ship = ship
    @fired_upon = false
    @render = "."
  end

  def empty?
    @empty
  end

  def place_ship(ship)
    @ship = ship
    @empty = false
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if @empty == false
     @ship.hit
    else
     @render = "M"
    end
  end
end
