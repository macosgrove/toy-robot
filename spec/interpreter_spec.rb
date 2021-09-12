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

    context "and the command includes parameters" do
      it "passes the parameters to the handler" do
        interpreter.process("test 1,2,THREE")
        expect(test_handler).to have_received(:test).with("1", "2", "THREE")
      end
    end
  end

  context "when the interpreter does not have a handler for the command" do
    let(:test_handler) { double(foo: "Bar") }

    before { interpreter.add_handler(test_handler) }

    it "returns an error message" do
      expect(interpreter.process("test")).to eq "Unknown command [test]"
    end
  end

  context "when multiple handlers can handle the same command" do
    let(:test_handler1) { double(test: "Test response 1\n") }
    let(:test_handler2) { double(test: "Test response 2\n") }

    before do
      interpreter.add_handler(test_handler1)
      interpreter.add_handler(test_handler2)
    end

    it "collects all the commands and returns the lot" do
      expect(interpreter.process("test")).to eq <<~OUT
        Test response 1
        Test response 2
      OUT
    end
  end
end
