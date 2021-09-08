# frozen_string_literal: true

require_relative "../lib/toy_robot"

describe ToyRobot do
  it "says hello" do
    expect(ToyRobot.new.run).to eq "hello world"
  end
end
