# frozen_string_literal: true

require_relative "interpreter"
require_relative "robot"
require_relative "table"
require_relative "controller"

class Factory
  def build(toy_robot)
    interpreter = Interpreter.new
    interpreter.add_handler(Robot.new(Table.new))
    interpreter.add_handler(Controller.new(toy_robot))
    interpreter
  end
end
