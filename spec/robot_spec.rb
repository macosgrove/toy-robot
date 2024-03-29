# frozen_string_literal: true

require_relative "../lib/robot"
require_relative "../lib/table"

describe Robot do
  let(:table) { instance_double(Table, valid_location?: true, add_robot: nil) }
  subject(:robot) { described_class.new(table) }

  describe "#place" do
    it "returns nil" do
      expect(robot.place(0, 0, :north)).to be_nil
    end

    [[1, 3, :east], ["1", 3, "EAST"], [1, "3", "E"], ["1", "3", "east"], [1, 3, "e"]].each do |args| # rubocop:disable Style/WordArray
      it "is liberal in what it accepts" do
        robot.place(*args)
        expect(robot.report).to eq "1,3,EAST"
      end
    end

    it "raises an error when the direction is uninterpretable" do
      expect { robot.place(1, 3, "Nantucket") }.to raise_error "Robot does not understand direction [Nantucket]."
    end

    context "when the location is outside the table boundaries" do
      before { allow(table).to receive(:valid_location?).and_return(false) }

      it "raises an error when the location is outside the table boundaries" do
        expect { robot.place(99, 99) }.to raise_error(/Robot cannot be placed/)
      end
    end
  end

  context "Once the robot has been PLACEd" do
    before { robot.place(1, 5, :west) }

    it "reports its location" do
      expect(robot.report).to eq "1,5,WEST"
    end

    it "can be moved to a valid location" do
      robot.move
      expect(robot.report).to eq "0,5,WEST"
    end

    it "can turn left" do
      robot.left
      expect(robot.report).to eq "1,5,SOUTH"
    end

    it "can turn right" do
      robot.right
      expect(robot.report).to eq "1,5,NORTH"
    end
  end

  context "Before the robot has been PLACEd" do
    %i[move left right].each do |command|
      it "raises an exception if #{command} is attempted" do
        expect { robot.send(command) }.to raise_error "Robot's position is undefined. PLACE the robot first."
      end
    end

    it "does not raise an exception if REPORT is attempted" do
      expect(robot.report).to be_nil
    end
  end

  describe "help" do
    it "lists the available robot commands", :aggregate_failures do
      expect(robot.help).to include "MOVE - move the toy robot one unit forward"
      expect(robot.help).to include "PLACE <x>,<y>,<facing> - place the robot on the table"
    end
  end
end
