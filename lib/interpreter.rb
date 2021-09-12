# frozen_string_literal: true

class Interpreter
  def initialize
    @handlers = []
  end

  def add_handler(handler)
    @handlers << handler
  end

  def process(original_command)
    command, args = parse_command(original_command)
    responses = []
    @handlers.each do |handler|
      next unless handler.respond_to?(command.to_sym)

      responses << handler.send(command.to_sym, *args)
    end
    return "Unknown command [#{command}]" if responses.empty?
    return nil if responses.compact.empty?

    responses.join
  end

  private

  def parse_command(original_command)
    parsed_command = original_command.split
    command = parsed_command[0].downcase
    args = []
    args += parsed_command[1].split(",") if parsed_command[1]
    [command, args]
  end
end
