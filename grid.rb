# Refine Array with two-dimenstional capabilities.
module TwoDimensional
  refine Array do
    def two_dimensional?
      all? { |e| e.respond_to? :each }
    end

    def rectangular?
      return true unless first # the empty array is rectangular
      two_dimensional? && all? { |e| e.size == first.size }
    end

    def flip
      map(&:reverse)
    end
  end
end

using TwoDimensional

# A two-dimensional array that can be geometrically transformed.
class Grid
  attr_reader :rows

  def initialize(rows: [])
    raise ArgumentError, 'Rectangular arrays required' unless rows.rectangular?
    raise ArgumentError, 'Array of arrays required' unless rows.two_dimensional?
    @rows = rows.freeze
  end

  def empty?
    rows.empty?
  end

  def rotate(clockwise: true)
    rotated = clockwise ? rows.transpose.flip : rows.flip.transpose
    self.class.new(rows: rotated)
  end

  def reflect(vertical: true)
    self.class.new(rows: vertical ? rows.reverse : rows.flip)
  end
end
