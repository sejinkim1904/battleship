require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/ship_placer'
require 'tty-box'
require 'pry'

def setup
  @cruiser = Ship.new("Cruiser", 3)
  @submarine = Ship.new("Submarine", 2)
  @cpu_cruiser = Ship.new("Cruiser", 3)
  @cpu_submarine = Ship.new("Submarine", 2)
  @line = "***************************************************"
  @ship_placer = ShipPlacer.new
end

@box_intro = TTY::Box.frame(
  width: 50,
  height: 15,
  align: :center,
  padding: 4,
  title: {top_left: 'BATTLESHIP with Ruby'}
  ) do
    "Welcome\nto\nBATTLESHIP\nPress Enter to play"
  end

def main_menu
  puts `clear`
  puts @box_intro
  intro = gets.strip
  if intro.empty?
    play
  else
    return
  end
end

def play
  puts `clear`
  setup
  puts "What is your name?"
  @name = gets.chomp.capitalize
  puts "#{@name} please enter a board size between 4 and 9:"
  @board_size = gets.chomp.to_i
  until @board_size  <= 9 && @board_size >= 4
    puts "Invalid number, please try again:"
    @board_size = gets.chomp.to_i
  end
  @user_board = Board.new(@name, @board_size)
  @cpu_board = Board.new("Jarvis", @board_size)
  @user_board.cells
  @cpu_board.cells

  puts `clear`
  puts "========#{@name}'s board========"
  puts @user_board.render
  puts @line
  puts "Prepare for battle against Jarvis."
  puts @line
  puts "#{@name}, you have a Submarine and Cruiser."
  puts @line
  puts "Please choose 3 coordinates to place your Cruiser.\ne.g. A1,A2,A3"
  puts @line

  ship_coordinates = gets.chomp.upcase.split(",")
  until @user_board.valid_placement?(@cruiser, ship_coordinates)
     puts "Invalid coordinates, please try again."
     ship_coordinates = gets.chomp.upcase.split(",")
  end

  @user_board.place(@cruiser, ship_coordinates)

  puts `clear`
  puts "========#{@name}'s board========"
  puts @user_board.render(true)
  puts @line
  puts "Please choose 2 coordinates to place your Submarine.\ne.g. A1,A2"
  puts @line

  ship_coordinates = gets.chomp.upcase.split(",")
  until @user_board.valid_placement?(@submarine, ship_coordinates)
     puts "Invalid coordinates, please try again."
     ship_coordinates = gets.chomp.upcase.split(",")
  end

  @user_board.place(@submarine, ship_coordinates)

  puts `clear`
  puts "========#{@name}'s board========"
  puts @user_board.render(true)
  puts @line
  puts "Jarvis has placed ships."
  puts @line
  @ship_placer.generate_coordinates_cruiser(@cpu_board, @board_size, @cpu_cruiser)
  @ship_placer.generate_coordinates_sub(@cpu_board, @board_size, @cpu_submarine)

  def player_turn
    shot = gets.chomp.upcase
    until @cpu_board.validate_coordinate?(shot) && !@cpu_board.cells[shot].fired_upon?
      puts "Invalid coordinates, try again."
      shot = gets.chomp.upcase
    end
    puts `clear`
    @cpu_board.cells[shot].fire_upon
    puts "========#{@name}'s board========"
    puts @user_board.render(true)
  end

  def cpu_turn
    cpu_shot = "#{((rand(1..@board_size)) + 64).chr}#{(rand(1..@board_size))}"
    until !@user_board.cells[cpu_shot].fired_upon?
      cpu_shot = "#{((rand(1..@board_size)) + 64).chr}#{(rand(1..@board_size))}"
    end
    @user_board.cells[cpu_shot].fire_upon
    puts "========Jarvis's board========"
    puts @cpu_board.render(true)
    puts @line
    puts "Enter a coordinate on Jarvis' board to fire upon."
    puts @line
  end

  until @user_board.all_ships_sunk? || @cpu_board.all_ships_sunk?
    cpu_turn
    player_turn
  end

  puts @line

  if @user_board.all_ships_sunk?
    puts "Jarvis has sunk all your ships :("
  elsif @cpu_board.all_ships_sunk?
    puts "Congradulations #{@name}, you defeated Jarvis!"
  end

  puts @line
  sleep(5)
  main_menu
end

main_menu
