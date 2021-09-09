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

  describe "supplied examples" do
    it "passes example (a)" do
      input.puts "PLACE 0,0,NORTH"
      input.puts "MOVE"
      input.puts "REPORT"

      input.rewind
      toy_robot.run

      expect(output.string).to eq "0,1,NORTH\n"
    end

    xit "passes example (b)" do
      input.puts "PLACE 0,0,NORTH"
      input.puts "LEFT"
      input.puts "REPORT"

      input.rewind
      toy_robot.run

      expect(output.string).to eq "0,0,WEST\n"
    end

    xit "passes example (c)" do
      input.puts "PLACE 1,2,EAST"
      input.puts "MOVE"
      input.puts "MOVE"
      input.puts "LEFT"
      input.puts "MOVE"
      input.puts "REPORT"

      input.rewind
      toy_robot.run

      expect(output.string).to eq "3,3,NORTH\n"
    end
  end
end
