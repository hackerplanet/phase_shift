require_relative 'builder'

module PhaseShift
  # Run a defined pipeline
  class Runner
    attr_reader :options

    def initialize(pipeline)
      @options = { pipeline: pipeline }
    end

    def run
      pipeline.call
    end

    def pipeline
      @pipeline ||= Builder.parse_file "#{options[:pipeline]}.rb"
    end
  end
end
