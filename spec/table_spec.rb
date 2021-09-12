# frozen_string_literal: true

require_relative "../lib/table"
require_relative "../lib/robot"

describe Table do
  subject(:table) { Table.new(3, 6) }

  describe "#valid_location" do
    context "When the coordinates are inside the table boundaries" do
      [[0, 0], [0, 5], [2, 0], [2, 5]].each do |coords|
        it "returns true" do
          expect(table.valid_location?(*coords)).to be true
        end
      end
    end

    context "When the coordinates are outside the table boundaries" do
      [[-1, 0], [2, -1], [2, 6], [3, 5]].each do |coords|
        it "returns false" do
          expect(table.valid_location?(*coords)).to be false
        end
      end
    end
  end

  describe "#map" do
    context "When there are no robots on the table" do
      it "outputs a blank map" do
        expect(table.map).to eq <<~MAP
          +---+
          |   |
          |   |
          |   |
          |   |
          |   |
          |   |
          +---+
        MAP
      end
    end

    context "When there is a robot on the table" do
      let(:robot) { instance_double(Robot, x: 2, y: 3, to_c: "^") }
      before { table.add_robot(robot) }

      it "outputs a map showing the robot's location and direction" do
        expect(table.map).to eq <<~MAP
          +---+
          |   |
          |   |
          |  ^|
          |   |
          |   |
          |   |
          +---+
        MAP
      end
    end
  end
end
