class Spiral
  attr_reader :grid

  def initialize(grid: nil, origin: :top_left)
    @grid = align_origin(grid, origin)
  end

  def to_a(clockwise: true)
    transformed = clockwise ? grid : grid.rotate.reflect(vertical: false)
    transpose_and_shift(transformed)
  end

  private

  def transpose_and_shift(grid)
    return [] if grid.empty?
    rows = grid.rows.dup
    shifted = rows.shift
    new_grid = grid.class.new(rows: rows).rotate(clockwise: false)
    shifted + transpose_and_shift(new_grid)
  end

  def align_origin(grid, origin)
    {
      top_left: grid,
      top_right: grid.rotate(clockwise: false),
      bottom_right: grid.rotate.rotate,
      bottom_left: grid.rotate
    }[origin] || grid
  end
end
