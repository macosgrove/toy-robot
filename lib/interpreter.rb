# frozen_string_literal: true

class Interpreter
  def initialize
    @handlers = []
  end

  def add_handler(handler)
    @handlers << handler
  end

  def process(original_command)
    command = original_command.chomp.downcase
    @handlers.each do |handler|
      return handler.send(command.to_sym) if handler.respond_to?(command.to_sym)
    end
    "Unknown command [#{command}]"
  end
end
