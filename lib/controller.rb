# frozen_string_literal: true

# Responsible for commands that control the application itself
class Controller
  def initialize(application)
    @app = application
  end

  def quit
    @app.output.puts "Goodbye"
    exit(0)
  end

  def verbose_on
    @app.verbose = true
    "Verbose is on"
  end

  def verbose_off
    @app.verbose = false
    "Verbose is off"
  end

  def reporting_on
    @app.reporting = true
    "Reporting is on"
  end

  def reporting_off
    @app.reporting = false
    "Reporting is off"
  end

  def help
    <<~HELP
      Application commands:
        REPORTING_ON - always report after each command
        REPORTING_OFF - stop reporting after each command
        VERBOSE_ON - report errors in the output
        VERBOSE_OFF - ignore errors
        QUIT - terminate the application
    HELP
  end
end
