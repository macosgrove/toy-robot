# frozen_string_literal: true

require_relative "interpreter"
require_relative "robot"
require_relative "table"
require_relative "controller"

class Factory
  def build(toy_robot)
    table = Table.new
    Interpreter.new.tap do |interpreter|
      interpreter.add_handler(table)
      interpreter.add_handler(Robot.new(table))
      interpreter.add_handler(Controller.new(toy_robot))
    end
  end
end
