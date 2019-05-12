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
    key_numbers = @cells.keys.map do |key|
      number_string.push(key[1])
    end
    number_header = " #{number_string.uniq.join(" ")} \n"

    numbers = key_numbers.flatten.uniq

    letter_header = ""
    key_renders = ""
    numbers.each do |number|
      letter_header += "#{(number.to_i + 64).chr} . . . . \n"
    end

    #
    # @cells.keys.each do |key|
    #   key[0] == letter_header











 #      key_render = letter_header.map do |line|
 # @cells.keys.[0] == letter_header[0]
 #        letter_header += " #{key_render}"
 #
 #
 #      key_renders {@cells.keys.map{ |key| key[0].ord == letter_header[0].ord}}


    " #{number_header}" + "#{letter_header}"
    end
  end
