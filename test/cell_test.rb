require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require 'pry'

class CellTest < MiniTest::Test
  def setup
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_cell_exists

    assert_instance_of Cell, @cell_1
  end

  def test_cell_has_coordinate

    assert_equal "B4", @cell_1.coordinate
  end

  def test_cell_has_ship

    assert_nil @cell_1.ship
  end

  def test_if_cell_is_empty?

    assert @cell_1.empty?
  end

  def test_ship_can_be_placed
    @cell_1.place_ship(@cruiser)
    assert_instance_of Ship, @cell_1.ship
  end

  def test_cell_is_not_empty_after_placing_ship
    @cell_1.place_ship(@cruiser)
    refute @cell_1.empty?
  end

  def test_cell_has_not_been_fired_upon
    @cell_1.place_ship(@cruiser)

    refute @cell_1.fired_upon?
  end

  def test_fire_upon_removes_1_health
  @cell_1.place_ship(@cruiser)
  @cell_1.fire_upon

  assert_equal 2, @cell_1.ship.health
  end

  def test_cell_has_been_fired_upon
    @cell_1.place_ship(@cruiser)
    @cell_1.fire_upon

    assert @cell_1.fired_upon?
  end

  def test_cell_render_puts_dot

    assert_equal ".", @cell_1.render
  end

  def test_if_cell_render_puts_M
    @cell_1.fire_upon

    assert_equal "M", @cell_1.render
  end

  def test_cell_render_after_placing_ship
    @cell_2.place_ship(@cruiser)

    assert_equal ".", @cell_2.render
  end

  def test_render_has_optional_argument
    @cell_2.place_ship(@cruiser)

    assert_equal "S", @cell_2.render(true)
  end

  def test_render_shows_hit
    @cell_2.place_ship(@cruiser)
    @cell_2.fire_upon

    assert_equal "H", @cell_2.render
  end

  def test_sunk_defaults_to_false

    refute @cruiser.sunk?
  end

end
