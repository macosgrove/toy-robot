# frozen_string_literal: true

require_relative "interpreter"
require_relative "robot"
require_relative "quitter"

# Entry point. Responsible for system intialisation and running the input loop.
class ToyRobot
  attr_accessor :verbose

  def initialize(input_stream, output_stream)
    @input = input_stream
    @output = output_stream
    @interpreter = Interpreter.new
    @interpreter.add_handler(Robot.new)
    @interpreter.add_handler(Quitter.new)
    @verbose = false
  end

  def run
    while (command = input.gets)
      begin
        response = interpreter.process(command)
        output.puts(response) if response
      rescue StandardError => e
        output.puts e.message if verbose
      end
    end
  end

  private

  attr :input, :output, :interpreter
end
