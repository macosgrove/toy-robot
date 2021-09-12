# frozen_string_literal: true

require_relative "../lib/controller"
require_relative "../lib/toy_robot"

describe Controller do
  let(:app) { instance_double(ToyRobot, :reporting= => nil, :verbose= => nil) }
  subject(:controller) { Controller.new(app) }

  it "turns reporting on and off", :aggregate_failures do
    controller.reporting_on
    expect(app).to have_received(:reporting=).with(true)
    controller.reporting_off
    expect(app).to have_received(:reporting=).with(false)
  end

  it "turns verbose mode on and off", :aggregate_failures do
    controller.verbose_on
    expect(app).to have_received(:verbose=).with(true)
    controller.verbose_off
    expect(app).to have_received(:verbose=).with(false)
  end

  it "lists the available controller commands", :aggregate_failures do
    expect(controller.help).to include "REPORTING_ON - always report after each command"
    expect(controller.help).to include "QUIT - terminate the application"
  end
end
