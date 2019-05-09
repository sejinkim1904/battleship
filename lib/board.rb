class Board
  attr_reader :cells

  def initialize
    @cells = build_grid
  end

  def validate_coordinate?(coordinate)
    @cells.keys.any? do |key|
      key == coordinate
    end
  end

  def build_grid
    grid = Hash.new
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
