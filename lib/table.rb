# frozen_string_literal: true

class Table
  def initialize(breadth = 5, depth = 5)
    # Coordinates are 0 based, so subtract 1 from dimensions
    @max_x = breadth.to_i - 1
    @max_y = depth.to_i - 1
  end

  def valid_location?(x, y) # rubocop:disable Naming/MethodParameterName
    x >= 0 && x <= @max_x && y >= 0 && y <= @max_y
  end
end
