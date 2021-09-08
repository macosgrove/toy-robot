# frozen_string_literal: true

require_relative "../lib/interpreter"

describe Interpreter do
  subject(:interpreter) { Interpreter.new }
  it "echoes the command" do
    expect(interpreter.process("test")).to eq "test"
  end
end
