require_relative 'spiral'
# Normally, we'd use a test double for the "RotatingFlippingArray" role
# fulfiled by this Grid class.
require_relative 'grid'
require 'minitest'
require 'minitest/autorun'

class SpiralTest < Minitest::Test
  def setup
    @klass = Spiral
  end

  # Helper that makes +Grid+ objects
  def grid_for(rows = [])
    Grid.new(rows: rows)
  end

  def test_empty_grid_prints_itself
    assert_equal grid_for.rows, @klass.new(grid: grid_for).to_a
  end

  def test_tiny_grid_returns_flattened_self
    grid = grid_for [%w(tiny)]
    assert_equal grid.rows.flatten, @klass.new(grid: grid).to_a
  end

  def test_small_square_grid_clockwise_spiral
    grid = grid_for [
      %w(a b c),
      %w(d e f),
      %w(g h i)
    ]
    expected = %w(a b c f i h g d e)
    assert_equal expected, @klass.new(grid: grid).to_a
  end

  def test_squat_rectangular_grid_makes_clockwise_spiral
    grid = grid_for [
      %w(a b c d),
      %w(e f g h),
      %w(i j k l)
    ]
    expected = %w(a b c d h l k j i e f g)
    assert_equal expected, @klass.new(grid: grid).to_a
  end

  def test_tall_rectangular_grid_makes_clockwise_spiral
    grid = grid_for [
      %w(a b c),
      %w(d e f),
      %w(g h i),
      %w(j k l)
    ]
    expected = %w(a b c f i l k j g d e h)
    assert_equal expected, @klass.new(grid: grid).to_a
  end

  def test_bigger_grid_makes_clockwise_spiral
    grid = grid_for [
      %w(a b c d e f g),
      %w(h i j k l m n),
      %w(o p q r s t u),
      %w(v w x y z 0 1),
      %w(2 3 4 5 6 7 8)
    ]
    expected = %w(a b c d e f g n u 1 8 7 6 5 4 3 2 v o h i j k l m t 0 z y x w p q r s)
    assert_equal expected, @klass.new(grid: grid).to_a
  end

  def test_counterclockwise_spiral
    grid = grid_for [
      %w(a b c d e f g),
      %w(h i j k l m n),
      %w(o p q r s t u),
      %w(v w x y z 0 1),
      %w(2 3 4 5 6 7 8)
    ]
    expected = %w(a h o v 2 3 4 5 6 7 8 1 u n g f e d c b i p w x y z 0 t m l k j q r s)
    assert_equal expected, @klass.new(grid: grid).to_a(clockwise: false)
  end

  def test_clockwise_from_top_right_corner
    grid = grid_for [
      %w(a b c d e),
      %w(f g h i j),
      %w(k l m n o),
      %w(p q r s t)
    ]
    expected = %w(e j o t s r q p k f a b c d i n m l g h)
    assert_equal expected, Spiral.new(grid: grid, origin: :top_right).to_a
  end

  def test_clockwise_from_bottom_right_corner
    grid = grid_for [
      %w(a b c d e),
      %w(f g h i j),
      %w(k l m n o),
      %w(p q r s t)
    ]
    expected = %w(t s r q p k f a b c d e j o n m l g h i)
    assert_equal expected, Spiral.new(grid: grid, origin: :bottom_right).to_a
  end

  def test_clockwise_from_bottom_left_corner
    grid = grid_for [
      %w(a b c d e),
      %w(f g h i j),
      %w(k l m n o),
      %w(p q r s t)
    ]
    expected = %w(p k f a b c d e j o t s r q l g h i n m)
    assert_equal expected, Spiral.new(grid: grid, origin: :bottom_left).to_a
  end

  def test_5x4_from_bottom_left_counterclockwise
    grid = grid_for [
      %w(a b c d e),
      %w(f g h i j),
      %w(k l m n o),
      %w(p q r s t)
    ]
    expected = %w(p q r s t o j e d c b a f k l m n i h g)
    assert_equal expected, Spiral.new(grid: grid, origin: :bottom_left).to_a(clockwise: false)
  end
end
