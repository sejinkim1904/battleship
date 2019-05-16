require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require 'pry'

class BoardTest < MiniTest::Test
  def setup
    @board = Board.new("board", 4)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)

  end

  def test_board_exists

    assert_instance_of Board, @board
  end

  def test_board_has_a_name

    assert_equal "board", @board.name
  end

  def test_board_has_cells

    assert @board.validate_coordinate?("A1")
    assert @board.validate_coordinate?("D4")
    refute @board.validate_coordinate?("A5")
    refute @board.validate_coordinate?("E1")
    refute @board.validate_coordinate?("A22")
  end

  def test_ship_has_valid_placement

    refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    refute @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    refute @board.valid_placement?(@submarine, ["A1", "C1"])
    refute @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    refute @board.valid_placement?(@submarine, ["C1", "B1"])
    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(@submarine, ["C2", "D3"])
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
    refute @board.valid_placement?(@cruiser, ["A1", "C4", "D3"])
  end

  def test_placing_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]

    assert_equal @cruiser, cell_1.ship
    assert_equal @cruiser, cell_2.ship
    assert_equal @cruiser, cell_3.ship
    assert cell_3.ship == cell_2.ship
  end

  def test_for_overlapping_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])

    refute @board.valid_placement?(@submarine, ["A1", "B1"])
  end

  def test_rendering_the_board
    @board.place(@cruiser, ["A1", "A2", "A3"])
    expected = "  1 2 3 4 \n" +
               "A . . . . \n" +
               "B . . . . \n" +
               "C . . . . \n" +
               "D . . . . \n"

    assert_equal expected, @board.render
    expected_2 ="  1 2 3 4 \n" +
                "A S S S . \n" +
                "B . . . . \n" +
                "C . . . . \n" +
                "D . . . . \n"

    assert_equal expected_2, @board.render(true)
  end

end
