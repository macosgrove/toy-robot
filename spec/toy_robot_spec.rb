# frozen_string_literal: true

require "stringio"

require_relative "../lib/toy_robot"

describe ToyRobot do
  let(:input) { double(IO) }

  context "When the input IO stream returns some commands and ends on nil" do
    before do
      allow(input).to receive(:gets).and_return("one", "two", "three", nil)
    end

    it "echoes the input until it encounters nil" do
      output = StringIO.new
      ToyRobot.new(input, output).run
      expect(output.string).to eq "one\ntwo\nthree\n"
    end
  end
end
