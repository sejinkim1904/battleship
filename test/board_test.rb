require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require 'pry'

class BoardTest < MiniTest::Test
  def setup
    @board = Board.new

  end

  def test_board_exists

    assert_instance_of Board, @board
  end

  def test_board_has_cells

    assert @board.validate_coordinate?("A1")
    assert @board.validate_coordinate?("D4")
    refute @board.validate_coordinate?("A5")
    refute @board.validate_coordinate?("E1")
    refute @board.validate_coordinate?("A22")
  end
end
