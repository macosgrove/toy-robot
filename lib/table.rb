# frozen_string_literal: true

class Table
  def initialize(breadth = 5, depth = 5)
    # Coordinates are 0 based, so subtract 1 from dimensions
    @max_x = breadth.to_i - 1
    @max_y = depth.to_i - 1
    @robots = []
  end

  def valid_location?(x, y)
    x >= 0 && x <= @max_x && y >= 0 && y <= @max_y
  end

  def add_robot(robot)
    @robots << robot
  end

  def map
    map = create_map(" ")
    @robots.each do |robot|
      map[robot.x][robot.y] = robot.to_c
    end
    print_map(map)
  end

  def help
    <<~HELP
      Table commands:
        MAP - display a map showing the location and direction of the robot
    HELP
  end

  private

  def create_map(init_char)
    [].tap do |map|
      0.upto(@max_x) do |x|
        map[x] = []
        0.upto(@max_y) do |y|
          map[x][y] = init_char
        end
      end
    end
  end

  def print_map(map)
    out = "+#{'-' * (@max_x + 1)}+\n"
    @max_y.downto(0) do |y|
      out += map_row(map, y)
    end
    out += "+#{'-' * (@max_x + 1)}+\n"
  end

  def map_row(map, y)
    row = "|"
    0.upto(@max_x) do |x|
      row += map[x][y]
    end
    "#{row}|\n"
  end
end
