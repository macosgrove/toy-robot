# frozen_string_literal: true

require_relative "../lib/toy_robot"

describe "Application integration" do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }

  subject(:toy_robot) { ToyRobot.new(input, output) }

  context "When the robot is placed and reports" do
    before do
      input.puts "PLACE"
      input.puts "REPORT"
      input.rewind
    end

    it "reports the robot's location" do
      toy_robot.run
      expect(output.string).to eq "0,0,NORTH\n"
    end
  end

  context "When location and direction are specified for the PLACE" do
    before do
      input.puts "PLACE 1,5,EAST"
      input.puts "REPORT"
      input.rewind
    end

    it "places the robot according to the parameters" do
      toy_robot.run
      expect(output.string).to eq "1,5,EAST\n"
    end
  end
end
