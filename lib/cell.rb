class Cell
  attr_reader :coordinate, :ship, :empty, :fired_upon, :render, :fire_upon, :place_ship


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
    end
    render
  end

  def render(reveal = false)
    if reveal == true && @fired_upon == false && @empty == false
      "S"
      elsif @fired_upon == true && @empty == false && @ship.sunk?
        "X"
      elsif @fired_upon == true && @empty == false
        "H"
      elsif @fired_upon == true && @empty == true
        "M"
      else "."
    end
  end
end
