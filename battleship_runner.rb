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
if intro.empty?

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
  puts "Please choose 3 coordinates to place your Cruiser.\ne.g. A1, A2, A3"
  puts "========#{name}'s board========"
  puts user_board.render

  ship_coordinates = gets.chomp.upcase.split(", ")
  user_board.place(@cruiser, ship_coordinates)

  puts user_board.render(true)



end
