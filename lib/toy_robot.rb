# frozen_string_literal: true

# Entry point. Responsible for system intialisation and running the input loop.
class ToyRobot
  def initialize(input_stream, output_stream)
    @input = input_stream
    @output = output_stream
    @interpreter = Interpreter.new
  end

  def run
    while (command = input.gets)
      output.puts(@interpreter.process(command))
    end
  end

  private

  attr :input, :output
end
