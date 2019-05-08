class Cell
  attr_reader :coordinate, :ship, :empty, :fired_upon, :render, :sunk

  def initialize(coordinate)
    @coordinate = coordinate
    @empty = true
    @ship = ship
    @fired_upon = false
    @render = "."
    @sunk = false
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
     @render = "H"
    else
     @render = "M"
    end
  end

  def render(reveal = false)
    if reveal == true
      @render = "S"
    else @render
    end
  end
end
