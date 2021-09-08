# frozen_string_literal: true

require "rspec/core/rake_task"

require_relative "lib/toy_robot"

desc "Run the toy robot application"
task :toy_robot do
  ToyRobot.new($stdin, $stdout).run
end

RSpec::Core::RakeTask.new(:spec)
