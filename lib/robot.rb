# frozen_string_literal: true

class RobotCommandError < StandardError; end

class Robot
  def place(x = 0, y = 0, facing = "north") # rubocop:disable Naming/MethodParameterName
    @x = x
    @y = y
    @facing = facing.to_sym
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
end
