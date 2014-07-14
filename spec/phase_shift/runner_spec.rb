require 'spec_helper'
require 'phase_shift/runner'

describe 'PhaseShift::Runner' do
  subject { PhaseShift::Runner.new(pipeline: 'spec/test') }

  context '#initialize' do
    it 'requires a specified pipeline' do
      expect {PhaseShift::Runner.new}.to raise_error
    end

    it 'sets the passed options' do
      runner = PhaseShift::Runner.new(pipeline: 'spec/test', test: 'value')
      expect(runner.options).to include(:test)
      expect(runner.options[:test]).to eq 'value'
    end
  end

  context '#run' do
    it 'calls the pipeline' do
      result = subject.run
      expect(result).to eq ['Phase 1', 'Phase 2', 'Phase 3', 'Phase 4']
    end
  end

  context '#pipeline' do
    it 'returns the pipeline' do
      expect(subject.pipeline).to respond_to :call
      expect(subject.pipeline.call).to \
        eq ['Phase 1', 'Phase 2', 'Phase 3', 'Phase 4']
    end
  end

  context '#options' do
    it 'returns the options hash' do
      expect(subject.options).to eq pipeline: 'spec/test'
    end
  end
end
