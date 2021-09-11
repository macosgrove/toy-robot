# frozen_string_literal: true

require_relative "interpreter"
require_relative "robot"
require_relative "table"
require_relative "quitter"

class Factory
  def build
    interpreter = Interpreter.new
    interpreter.add_handler(Robot.new(Table.new))
    interpreter.add_handler(Quitter.new)
    interpreter
  end
end
