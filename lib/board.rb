class Board
  attr_reader :name, :cells, :numbers, :letters, :ships

  def initialize(name = nil, board_size = nil)
    @name = name
    @numbers = []
    @letters = []
    @cells = build_grid(board_size)
    @ships = []
  end

  def valid_placement?(ship, coordinates)
    are_they_valid = coordinates.all? do |coord|
      validate_coordinate?(coord)
    end
    if are_they_valid == false
      return false
    end
    if coordinates.length == ship.length && coordinates.all? {|coordinate| @cells[coordinate].empty?}
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

  def build_grid(num)
    grid = {}
    ("A".."#{(num + 64).chr}").each do |letter|
      (1..num).each do |num|
        @letters << letter
        @numbers << num
        coordinates = "#{letter}#{num}"
        grid[coordinates] = Cell.new(coordinates)
      end
    end
    grid
  end

  def place(ship,coordinates)
    if !valid_placement?(ship,coordinates)
      return nil
    end
    coordinates.each do |coordinate|
    @cells[coordinate].place_ship(ship)
    end
    @ships << ship
    ship
  end

  def all_ships_sunk?
    @ships.all? do |ship|
      ship.sunk?
    end
  end

  def render(reveal = false)
    board = "  #{@numbers.uniq.join(" ")} \n"
    letter_lines = ""
    @letters.uniq.each do |letter|
    letter_lines += "#{letter}"
      @numbers.uniq.each do |number|
        letter_lines += " #{@cells["#{letter}#{number}"].render(reveal)}"
      end
      letter_lines += " \n"
    end
      board << letter_lines
  end
end
