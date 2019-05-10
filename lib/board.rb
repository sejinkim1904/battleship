class Board
  attr_reader :cells

  def initialize
    @cells = build_grid
  end

  def valid_placement?(ship, coordinates)
    letter_by_itself = coordinates.map { |coordinate| coordinate[0] }
    number_by_itself = coordinates.map { |coordinate| coordinate[1] }
    letter_byself_same_value = if letter_by_itself.uniq.length == letter_by_itself.length
    end
    number_byself_same_value = if number_by_itself.uniq.length == number_by_itself.length
    end
    letter_order = ("A".."D").each_cons(ship.length) { |letter| p letter }
    number_order = (1..4).each_cons(ship.length) { |number| p number }

    if coordinates.length == ship.length
      # if the number of coordinates is equal to ship's length
      if letter_byself_same_value && (number_by_itself == number_order.any?)
      #if the letters are the same and the numbers are consecutive
    elsif (letter_by_itself == letter_order.any?) && number_byself_same_value
      # if the letters are consecutive and the numbers are the same
      else false
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
