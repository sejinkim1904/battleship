require './lib/cell'
require './lib/ship'
require './lib/board'
require 'tty-box'
require 'pry'

@cruiser = Ship.new("Cruiser", 3)
@submarine = Ship.new("Submarine", 2)
@line = "__________________________________"

box_intro = TTY::Box.frame(
  width: 50,
  height: 15,
  align: :center,
  padding: 4,
  title: {top_left: 'BATTLESHIP with Ruby'}
) do
  "Welcome\nto\nBATTLESHIP\nPress Enter to play"
end

puts box_intro
intro = gets.strip
# if intro.empty?
def play

  puts "what is your name?"
  name = gets.chomp.capitalize

  puts "#{name} please enter a board size between 4 and 10:"
  board_size = gets.chomp.to_i

  user_board = Board.new(name, board_size)
  cpu_board = Board.new("Jarvis", board_size)
  user_board.cells
  cpu_board.cells

  puts "Prepare for battle against Jarvis."
  puts @line
  puts "#{name}, you have a Submarine and Cruiser."
  puts @line
  puts "Please choose 3 coordinates to place your Cruiser.\ne.g. A1,A2,A3"
  puts "========#{name}'s board========"
  puts user_board.render
  puts @line

  ship_coordinates = gets.chomp.upcase.split(",")
  until ship_coordinates.all? { |coord| user_board.validate_coordinate?(coord) } && user_board.valid_placement?(@cruiser, ship_coordinates)
     puts "Invalid coordinates, please try again."
     ship_coordinates = gets.chomp.upcase.split(",")
  end

  user_board.place(@cruiser, ship_coordinates)


  puts "========#{name}'s board========"
  puts user_board.render(true)
  puts @line
  puts "Please choose 2 coordinates to place your Submarine.\ne.g. A1,A2"
  puts @line

  ship_coordinates = gets.chomp.upcase.split(",")
  until ship_coordinates.all? { |coord| user_board.validate_coordinate?(coord) } && user_board.valid_placement?(@submarine, ship_coordinates)
     puts "Invalid coordinates, please try again."
     ship_coordinates = gets.chomp.upcase.split(",")
  end

  user_board.place(@submarine, ship_coordinates)

  puts "========#{name}'s board========"
  puts user_board.render(true)
  puts @line

  puts "Jarvis has placed ships, pick a coordinate to fire upon"
  #Computer places cruiser
  cpu_ship_coordinates_1 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
  cpu_ship_coordinates_2 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
  cpu_ship_coordinates_3 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
  cpu_random_coordinates_3 = cpu_ship_coordinates_1,cpu_ship_coordinates_2,cpu_ship_coordinates_3
  until cpu_random_coordinates_3.all? { |coord| user_board.validate_coordinate?(coord) } && cpu_board.valid_placement?(@cruiser, cpu_random_coordinates_3)

     cpu_ship_coordinates_1 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
     cpu_ship_coordinates_2 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
     cpu_ship_coordinates_3 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
     cpu_random_coordinates_3 = cpu_ship_coordinates_1,cpu_ship_coordinates_2,cpu_ship_coordinates_3
  end

  cpu_board.place(@cruiser, cpu_random_coordinates_3)

  #Computer places submarine
  cpu_ship_coordinates_1 = "#{((rand(1..board_size)) +64).chr}#{(rand(1..board_size))}"
  cpu_ship_coordinates_2 = "#{((rand(1..board_size)) +64).chr}#{(rand(1..board_size))}"
  cpu_random_coordinates_2 =cpu_ship_coordinates_1,cpu_ship_coordinates_2
  until cpu_random_coordinates_2.all? { |coord| user_board.validate_coordinate?(coord) } && cpu_board.valid_placement?(@submarine, cpu_random_coordinates_2)


      cpu_ship_coordinates_1 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
      cpu_ship_coordinates_2 = "#{((rand(1..board_size)) + 64).chr}#{(rand(1..board_size))}"
      cpu_random_coordinates_2 = cpu_ship_coordinates_1,cpu_ship_coordinates_2
   end

  cpu_board.place(@submarine, cpu_random_coordinates_2)

  puts cpu_board.render(true)

  puts @line

  unless player_board.all_ships_sunk? || cpu_board.all_ships_sunk?
    player_turn
    cpu_turn
  end

  def player_turn
    shot = gets.chomp.upcase
    cpu_board.cells[shot].fire_upon
    puts cpu_board.render(true)
  end

  def cpu_turn
    cpu_shot = generate_random_number
    player_board.cells[shot].fire_upon
    puts player_board.render(true)
  end
end

# create player class which takes in name and ship placements and has a
# take_turn method


play
#
# player turn
# cpu turn
# ships.sunk?
