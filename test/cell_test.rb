require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require 'pry'

class CellTest < MiniTest::Test
  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_cell_exists

    assert_instance_of Cell, @cell
  end

  def test_cell_has_coordinate

    assert_equal "B4", @cell.coordinate
  end

  def test_cell_has_ship

    assert_nil @cell.ship
  end

  def test_if_cell_is_empty?

    assert @cell.empty?
  end

  def test_ship_can_be_placed
    @cell.place_ship(@cruiser)
    assert_instance_of Ship, @cell.ship
  end

  def test_cell_is_not_empty_after_placing_ship
    @cell.place_ship(@cruiser)
    refute @cell.empty?
  end
end
