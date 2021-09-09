# frozen_string_literal: true

require_relative "../lib/robot"

describe Robot do
  subject(:robot) { described_class.new }

  it "can be placed on the table (PLACE command)" do
    expect(robot.place(0, 0, :north)).to be_nil
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
