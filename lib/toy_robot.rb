# frozen_string_literal: true

# Entry point. Responsible for running the input loop.
class ToyRobot
  def initialize(input_stream, output_stream)
    @input = input_stream
    @output = output_stream
  end

  def run
    while (line = input.gets)
      output.puts(line)
    end
  end

  private

  attr :input, :output
end
