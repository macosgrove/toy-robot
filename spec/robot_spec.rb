# frozen_string_literal: true

require_relative "../lib/robot"

describe Robot do
  subject(:robot) { described_class.new }

  it "can be placed on the table (PLACE command)" do
    expect { robot.place(0, 0, :north) }.not_to raise_error
  end
end
