# frozen_string_literal: true

require_relative "interpreter"
require_relative "quitter"

# Entry point. Responsible for system intialisation and running the input loop.
class ToyRobot
  def initialize(input_stream, output_stream)
    @input = input_stream
    @output = output_stream
    @interpreter = Interpreter.new
    @interpreter.add_handler(Quitter.new)
  end

  def run
    while (command = input.gets)
      output.puts(@interpreter.process(command))
    end
  end

  private

  attr :input, :output
end
