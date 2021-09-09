# frozen_string_literal: true

require_relative "../lib/robot"

describe Robot do
  subject(:robot) { described_class.new }

  describe "#place" do
    it "returns nil" do
      expect(robot.place(0, 0, :north)).to be_nil
    end

    [[1, 3, :east], ["1", 3, "EAST"], [1, "3", "E"], %w[1 3 east], [1, 3, "e"]].each do |args|
      it "is liberal in what it accepts" do
        robot.place(*args)
        expect(robot.report).to eq "1,3,EAST"
      end
    end

    it "raises an error when the direction is uninterpretable" do
      expect { robot.place(1, 3, "Nantucket") }.to raise_error "Robot does not understand direction [Nantucket]."
    end
  end

  context "Once the robot has been PLACEd" do
    before { robot.place(1, 5, :west) }

    it "reports its location" do
      expect(robot.report).to eq "1,5,WEST"
    end
  end

  context "Before the robot has been PLACEd" do
    it "raises an exception if REPORT is attempted" do
      expect { robot.report }.to raise_error "Robot's position is undefined. PLACE the robot first."
    end
  end
end
