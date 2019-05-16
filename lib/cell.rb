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
    if @ship
      if reveal
        if @ship.sunk?
          @render = "X"
        elsif @fired_upon
          return "H"
        else
          @render = "S"
        end
      else
        if @ship.sunk?
          @render = "X"
        elsif @fired_upon
          @render = "H"
        else
          @render = "."
        end
      end
    else
      if reveal
        if @fired_upon
          @render = "M"
        else
          @render = "."
        end
      else
        if @fired_upon
          @render = "M"
        else
          @render = "."
        end
      end
    end
  end
end
