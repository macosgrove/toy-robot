# frozen_string_literal: true

class RobotCommandError < StandardError; end

class Robot
  def place(x = "0", y = "0", facing = "north") # rubocop:disable Naming/MethodParameterName
    @x = x.to_i
    @y = y.to_i
    @facing = get_direction(facing)
    nil
  end

  def move
    raise RobotCommandError, "Robot's position is undefined. PLACE the robot first." unless placed?

    @x += MOVE_VECTORS[@facing][0]
    @y += MOVE_VECTORS[@facing][1]
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
    raise RobotCommandError, "Robot's position is undefined. PLACE the robot first." unless placed?

    "#{@x},#{@y},#{@facing.to_s.upcase}"
  end

  private

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

  COMPASS = %i[north east south west].freeze
  LEFT = -1
  RIGHT = 1
end
