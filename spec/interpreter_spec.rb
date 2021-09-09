# frozen_string_literal: true

require_relative "../lib/interpreter"

describe Interpreter do
  subject(:interpreter) { described_class.new }

  context "when the interpreter has a handler for the command" do
    let(:test_handler) { double(test: "Test response") }

    before { interpreter.add_handler(test_handler) }

    it "invokes the command on the handler and returns the response" do
      expect(interpreter.process("test")).to eq "Test response"
    end

    it "strips off newline characters if any" do
      expect(interpreter.process("test\n")).to eq "Test response"
    end

    it "is not case sensitive" do
      expect(interpreter.process("TEST")).to eq "Test response"
    end
  end

  context "when the interpreter does not have a handler for the command" do
    let(:test_handler) { double(foo: "Bar") }

    before { interpreter.add_handler(test_handler) }

    it "returns an error message" do
      expect(interpreter.process("test")).to eq "Unknown command [test]"
    end
  end
end
