require_relative 'grid'
require 'minitest'
require 'minitest/autorun'

# :nodoc:
class GridTest < Minitest::Test
  def setup
    @klass = Grid
  end

  def test_is_empty_by_default
    assert(@klass.new.empty?)
  end

  def test_exposes_array_of_rows
    assert_equal([], @klass.new.rows)
  end

  def test_rows_is_initial_array_passed_in
    input = [
      %w(a b c d e),
      %w(f g h i j)
    ]
    assert_equal(input, @klass.new(rows: input).rows)
  end

  def test_is_not_empty_given_rows
    input = [
      %w(a b c d e),
      %w(f g h i j)
    ]
    refute(@klass.new(rows: input).empty?)
  end

  def test_rejects_non_rectangular_input
    input = [
      %w(a b c d e),
      %w(f g h i)
    ]
    assert_raises(ArgumentError) { @klass.new(rows: input) }
  end

  def test_rejects_linear_arrays
    input = %w(x y z)
    assert_raises(ArgumentError) { @klass.new(rows: input) }
  end

  def test_rejects_arrays_of_other_things
    input = Array.new(3) { Object.new }
    assert_raises(ArgumentError) { @klass.new(rows: input) }
  end

  def test_can_be_rotated_clockwise
    input = [%w(a b c d e), %w(f g h i j)]
    expected = [%w(f a), %w(g b), %w(h c), %w(i d), %w(j e)]
    rotated = @klass.new(rows: input).rotate(clockwise: true)
    assert_equal(expected, rotated.rows)
  end

  def test_rotates_clockwise_by_default
    input = [%w(a b c d e), %w(f g h i j)]
    expected = [%w(f a), %w(g b), %w(h c), %w(i d), %w(j e)]
    rotated = @klass.new(rows: input).rotate
    assert_equal(expected, rotated.rows)
  end

  def test_can_rotate_counter_clockwise
    input = [%w(a b c d e), %w(f g h i j)]
    expected = [%w(e j), %w(d i), %w(c h), %w(b g), %w(a f)]
    rotated = @klass.new(rows: input).rotate(clockwise: false)
    assert_equal(expected, rotated.rows)
  end

  def test_equivalence_of_both_rotation_directions
    input = [%w(a b c d e), %w(f g h i j)]
    cw = @klass.new(rows: input).rotate.rotate.rotate
    ccw = @klass.new(rows: input).rotate(clockwise: false)
    assert_equal(cw.rows, ccw.rows)
  end

  def test_can_reflect_vertically
    input = [%w(a b c d e), %w(f g h i j)]
    expected = [%w(f g h i j), %w(a b c d e)]
    assert_equal(expected, @klass.new(rows: input).reflect(vertical: true).rows)
  end

  def test_reflects_vertically_by_default
    input = [%w(a b c d e), %w(f g h i j)]
    expected = [%w(f g h i j), %w(a b c d e)]
    assert_equal(expected, @klass.new(rows: input).reflect.rows)
  end

  def test_can_reflect_horizontally
    input = [%w(a b c d e), %w(f g h i j)]
    expected = [%w(e d c b a), %w(j i h g f)]
    assert_equal(expected, @klass.new(rows: input).reflect(vertical: false).rows)
  end
end
