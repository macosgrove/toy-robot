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
      input.puts "PLACE 1,4,EAST"
      input.puts "REPORT"
      input.rewind
    end

    it "places the robot according to the parameters" do
      toy_robot.run
      expect(output.string).to eq "1,4,EAST\n"
    end
  end

  describe "supplied examples" do
    it "passes example (a)" do
      input.write <<~IN
        PLACE 0,0,NORTH
        MOVE
        REPORT
      IN

      input.rewind
      toy_robot.run

      expect(output.string).to eq "0,1,NORTH\n"
    end

    it "passes example (b)" do
      input.write <<~IN
        PLACE 0,0,NORTH
        LEFT
        REPORT
      IN

      input.rewind
      toy_robot.run

      expect(output.string).to eq "0,0,WEST\n"
    end

    it "passes example (c)" do
      input.write <<~IN
        PLACE 1,2,EAST
        MOVE
        MOVE
        LEFT
        MOVE
        REPORT
      IN

      input.rewind
      toy_robot.run

      expect(output.string).to eq "3,3,NORTH\n"
    end
  end

  describe "More complex examples" do
    before { toy_robot.verbose = true }
    it "can turn right as well as left" do
      input.write <<~IN
        PLACE 1,2,EAST
        MOVE
        MOVE
        RIGHT
        MOVE
        RIGHT
        MOVE
        LEFT
        MOVE
        REPORT
      IN

      input.rewind
      toy_robot.run

      expect(output.string).to eq "2,0,SOUTH\n"
    end

    it "ignores commands that would have it fall off the table" do
      input.write <<~IN
        PLACE 4,4,NORTH
        MOVE
        LEFT
        MOVE
        REPORT
      IN

      input.rewind
      toy_robot.run

      expect(output.string).to eq <<~OUT
        Robot will not move past edge of table to [4,5]
        3,4,WEST
      OUT
    end
  end

  describe "Extension examples" do
    it "allows automatic reporting to be turned on at any time" do
      input.write <<~IN
        REPORTING_ON
        PLACE 1,2,EAST
        MOVE
        LEFT
        REPORTING_OFF
        RIGHT
      IN

      input.rewind
      toy_robot.run

      expect(output.string).to eq <<~OUT
        Reporting is on

        1,2,EAST
        2,2,EAST
        2,2,NORTH
        Reporting is off
      OUT
    end

    it "lists available commands with HELP" do
      input.puts "HELP"
      input.rewind
      toy_robot.run

      output.rewind
      help = output.readlines

      expect(help).to include "  REPORTING_ON - always report after each command\n"
      expect(help).to include "  MOVE - move the toy robot one unit forward\n"
    end
  end
end
