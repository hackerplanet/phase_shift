module PhaseShift
  # Create a pipeline by building up stages
  class Builder
    def self.parse_file(config, file = '(phase_shift)')
      builder_script = ::File.read(config)
      code = "PhaseShift::Builder.new {\n" + builder_script + "\n}.pipeline"
      eval code, TOPLEVEL_BINDING, file, 0
    end

    def initialize(default_stage = nil, &block)
      @default_stage = default_stage || proc { [] }
      @use = []
      instance_eval(&block) if block_given?
    end

    def use(stage, *args)
      @use << proc { |pipeline| stage.new(pipeline, *args) }
    end

    def pipeline
      @use.inject(@default_stage) { |a, e| e[a] }
    end

    def run
      pipeline.call
    end
  end
end
