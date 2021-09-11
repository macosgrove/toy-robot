# frozen_string_literal: true

require_relative "factory"

# Entry point. Responsible for calling the Factory to initialise the system, then running the input loop.
class ToyRobot
  attr_accessor :verbose

  def initialize(input_stream, output_stream)
    @input = input_stream
    @output = output_stream
    @interpreter = Factory.new.build
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
