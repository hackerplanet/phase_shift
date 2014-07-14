require_relative 'builder'

module PhaseShift
  # Run a defined pipeline
  class Runner
    def initialize(options = nil)
      @options = options
    end

    def run
      pipeline.call
    end

    def pipeline
      fail 'No specified pipeline' unless options.include? :pipeline
      @pipeline ||= Builder.parse_file "#{options[:pipeline]}.rb"
    end

    def options
      @options ||= parse_options(ARGV)
    end

    def default_options
      {}
    end

    private

    def parse_options(argv)
      @options = default_options
      @options[:pipeline] = argv.first if argv.length > 0
      @options
    end
  end
end
