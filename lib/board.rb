class Board
  attr_reader :cells

  def initialize
    @cells = build_grid
  end

  def valid_placement?(ship, coordinates)
    if coordinates.length == ship.length
      letter_by_itself = coordinates.map { |coordinate| coordinate[0] }
      number_by_itself = coordinates.map { |coordinate| coordinate[1].to_i }
      if letter_by_itself.uniq.length == 1
        number_by_itself.each_cons(2).all?{ |x, y| y == x + 1  }
      elsif number_by_itself.uniq.length == 1
        letter_by_itself.each_cons(2).all?{ |x, y| y.ord == x.ord + 1  }
      end
    end
  end

  def validate_coordinate?(coordinate)
    @cells.keys.any? do |key|
      key == coordinate
    end
  end

  def build_grid
    grid = {}
    ('A'..'D').each do |letter|
      (1..4).each do |num|
        coordinates = "#{letter}#{num}"
        grid[coordinates] = Cell.new(coordinates)
      end
    end
    grid
  end

end






# def cells
#   file = File.open(filename, "r")
#   coordinates = {}
#   file.each_line do |line|
#     coordinates.push(line)
#   end
#   cells = {}
#   coordinates.each do |coordinate|
#     cells.push(Cell.new(coordinate.first))
#   end
#   cells
# end
