require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'
require 'pry'

class ShipTest < MiniTest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists

    assert_instance_of Ship, @cruiser
  end

  def test_case_name

    assert_equal "Cruiser", @cruiser.name
  end

  def test_that_it_has_a_length

    assert_equal 3, @cruiser.length
  end

  def test_cruiser_health

    assert_equal 3, @cruiser.health
  end

  def test_has_it_sunk

    refute @cruiser.sunk?
  end

  def test_it_can_take_a_hit
    @cruiser.hit

    assert_equal 2, @cruiser.health
  end

  def test_can_it_take_another_hit
    @cruiser.hit
    @cruiser.hit

    assert_equal 1, @cruiser.health
    refute @cruiser.sunk?
  end

  def test_can_it_take_another_hit
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit

    assert @cruiser.sunk?
  end
end
