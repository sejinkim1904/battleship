class Board
  attr_reader :cells

  def initialize
    @cells = build_grid
  end

  def valid_placement?(ship, coordinates)
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


  def place(ship,coordinates)
    coordinates.each do |coordinate|
    @cells[coordinate].place_ship(ship)
    end
  end

  def render
    number_string = []
    letter_and_numbers = @cells.keys.map do |key|
      number_string.push(key[1])
    end
    # " #{number_string.uniq.join(" ")} \n"

    numbers = letter_and_numbers.flatten.uniq
    render_string = ""
    numbers.each do |number|
      render_string += "#{number}. . .\n"
    end

    render_string

    #
    # "#{@cell.keys[0][0]} #{@board.cells["A1"].render} #{@board.cells["B1"].render} #{@board.cells["C1"].render} #{@board.cells["D1"].render} \n"
    # letter_string = []
    # @cells.keys.map do |key|
    #   letter_string.push(key[0])

  
    end
  end
