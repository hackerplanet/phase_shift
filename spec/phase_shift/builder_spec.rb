require 'spec_helper'
require 'phase_shift/builder'

describe 'PhaseShift::Builder' do
  subject { PhaseShift::Builder }

  let(:stage) do
    double.as_null_object
  end

  let(:stage_two) do
    double.as_null_object
  end

  context '.parse_file' do
    it 'evaluates the passed file to a callable object' do
      expect(subject.parse_file('spec/test.rb')).to respond_to :call
    end
  end

  context '#initialize' do
    it 'evaluates the passed block in the context of the object' do
      expect { subject.new { fail "Stage Count: #{stages.count}" } }\
        .to raise_error('Stage Count: 0')
    end
  end

  context '#use' do
    it 'adds the passed stage to the pipeline' do
      builder = subject.new
      builder.use stage

      builder.run

      expect(stage).to have_received(:new).with(duck_type(:call))
    end

    it 'passes the specified arguments to the stage' do
      builder = subject.new
      string = 'This'
      builder.use stage, string

      builder.run

      expect(stage).to have_received(:new).with(duck_type(:call), be(string))
    end

    it 'adds all the specified stages to the pipeline' do
      builder = subject.new
      builder.use stage
      builder.use stage_two

      expect(builder.stages.count).to eq(2)
    end
  end

  context '#pipeline' do
    it 'has a default stage that returns an empty array' do
      expect(subject.new.pipeline.call).to eq([])
    end

    it 'allows the first stage of the pipeline to be customized' do
      expect(subject.new(proc { [1] }).pipeline.call).to eq([1])
    end

    it 'build the pipeline out of stages' do
      builder = subject.new
      builder.use stage
      builder.use stage_two

      builder.pipeline

      expect(stage).to have_received(:new).with(duck_type(:call))
      expect(stage_two).to have_received(:new).with(duck_type(:call))
    end
  end

  context '#run' do
    it 'calls the stages in the pipeline' do
      builder = subject.new
      builder.use stage
      builder.run

      expect(stage).to have_received(:call)
    end
  end
end
