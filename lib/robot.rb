# frozen_string_literal: true

class RobotCommandError < StandardError; end

class Robot
  attr :x, :y

  def initialize(table)
    @table = table
  end

  def place(x = "0", y = "0", facing = "north")
    @x = x.to_i
    @y = y.to_i

    unless table.valid_location?(@x, @y)
      raise RobotCommandError, "Robot cannot be placed at [#{@x},#{@y}]: it is outside table boundaries."
    end

    @facing = get_direction(facing)
    table.add_robot(self)
    nil
  end

  def move
    raise RobotCommandError, "Robot's position is undefined. PLACE the robot first." unless placed?

    new_x = @x + MOVE_VECTORS[@facing][0]
    new_y = @y + MOVE_VECTORS[@facing][1]

    unless table.valid_location?(new_x, new_y)
      raise RobotCommandError, "Robot will not move past edge of table to [#{new_x},#{new_y}]"
    end

    @x = new_x
    @y = new_y
    nil
  end

  def left
    raise RobotCommandError, "Robot's position is undefined. PLACE the robot first." unless placed?

    @facing = COMPASS[turn(LEFT)]
    nil
  end

  def right
    raise RobotCommandError, "Robot's position is undefined. PLACE the robot first." unless placed?

    @facing = COMPASS[turn(RIGHT)]
    nil
  end

  def report
    placed? ? "#{@x},#{@y},#{@facing.to_s.upcase}" : nil
  end

  def help
    <<~HELP
      Robot commands:
        PLACE <x>,<y>,<facing> - place the robot on the table
        MOVE - move the toy robot one unit forward
        LEFT - turn 90 degrees left
        RIGHT - turn 90 degrees right
        REPORT - report the robot's position
    HELP
  end

  def to_c
    COMPASS_CHARS[@facing]
  end

  private

  attr :table

  def placed?
    @x && @y && @facing
  end

  def get_direction(facing)
    case facing.to_s.downcase
    when "n", "north" then :north
    when "e", "east" then :east
    when "s", "south" then :south
    when "w", "west" then :west
    else
      raise RobotCommandError, "Robot does not understand direction [#{facing}]."
    end
  end

  def turn(direction)
    (COMPASS.index(@facing) + direction) % 4
  end

  MOVE_VECTORS =
    {
      north: [0, 1],
      east: [1, 0],
      south: [0, -1],
      west: [-1, 0]
    }.freeze

  COMPASS_CHARS =
    {
      north: "^",
      east: ">",
      south: "v",
      west: "<"
    }.freeze

  COMPASS = %i[north east south west].freeze
  LEFT = -1
  RIGHT = 1
end
