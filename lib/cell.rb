class Cell
  attr_reader :coordinate, :ship, :empty

  def initialize(coordinate)
    @coordinate = coordinate
    @empty = true
    @ship = ship
  end

  def empty?
    @empty
  end
end
