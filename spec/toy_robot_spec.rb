# frozen_string_literal: true

require "stringio"

require_relative "../lib/toy_robot"

describe ToyRobot do
  let(:input) { double(IO) }
  let(:output) { StringIO.new }

  subject(:toy_robot) { described_class.new(input, output) }

  context "When the input IO stream returns some commands and ends on nil" do
    let(:interpreter) { double(Interpreter, add_handler: nil) }

    before do
      allow(input).to receive(:gets).and_return("a", "b", "c", nil)
      allow(Interpreter).to receive(:new).and_return(interpreter)
      allow(interpreter).to receive(:process).with("a").and_return "one"
      allow(interpreter).to receive(:process).with("b").and_return "two"
      allow(interpreter).to receive(:process).with("c").and_return "three"
    end

    it "outputs the response from the interpreter until it encounters nil" do
      toy_robot.run
      expect(output.string).to eq "one\ntwo\nthree\n"
    end

    context "When the command causes an error" do
      before { allow(interpreter).to receive(:process).with("b").and_raise "Robot error" }

      context "and verbose is turned on" do
        before { toy_robot.verbose = true }

        it "reports the error to the output and continues processing" do
          toy_robot.run
          expect(output.string).to eq "one\nRobot error\nthree\n"
        end
      end

      context "and verbose is turned off" do
        before { toy_robot.verbose = false }

        it "ignores the error and continues processing" do
          toy_robot.run
          expect(output.string).to eq "one\nthree\n"
        end
      end
    end
  end
end
