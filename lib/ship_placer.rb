class ShipPlacer
  def initialize
  end

  def generate_coordinates_cruiser(cpu_board, board_size, ship)
    cpu_ship_coordinates_1 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
    cpu_ship_coordinates_2 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
    cpu_ship_coordinates_3 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
    cpu_random_coordinates_3 = cpu_ship_coordinates_1,cpu_ship_coordinates_2,cpu_ship_coordinates_3
    ship_placed = cpu_board.place(ship,cpu_random_coordinates_3)
    until !ship_placed.nil?
      cpu_ship_coordinates_1 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
      cpu_ship_coordinates_2 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
      cpu_ship_coordinates_3 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
      cpu_random_coordinates_3 = cpu_ship_coordinates_1,cpu_ship_coordinates_2,cpu_ship_coordinates_3
      ship_placed = cpu_board.place(ship, cpu_random_coordinates_3)
    end
  end

  def generate_coordinates_sub (cpu_board, board_size, ship)
    cpu_ship_coordinates_1 = "#{((rand(1..board_size)) +64).chr}#{(rand(1..board_size))}"
    cpu_ship_coordinates_2 = "#{((rand(1..board_size)) +64).chr}#{(rand(1..board_size))}"
    cpu_random_coordinates_2 =cpu_ship_coordinates_1,cpu_ship_coordinates_2
    ship_placed = cpu_board.place(ship ,cpu_random_coordinates_2)
    until ship_placed != nil
      cpu_ship_coordinates_1 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
      cpu_ship_coordinates_2 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
      cpu_random_coordinates_2 = cpu_ship_coordinates_1,cpu_ship_coordinates_2
      ship_placed = cpu_board.place(ship ,cpu_random_coordinates_2)
     end

  end

end
