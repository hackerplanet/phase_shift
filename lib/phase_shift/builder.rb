module PhaseShift
  class Builder
    def self.parse_file(config, file="(phase_shift)")
      builder_script = ::File.read(config)
      eval "PhaseShift::Builder.new {\n" + builder_script + "\n}.pipeline", TOPLEVEL_BINDING, file, 0
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
      @use.inject(@default_stage) { |p,e| e[p] }
    end
  end
end
