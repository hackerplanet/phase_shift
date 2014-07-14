#!/usr/bin/env ruby
$LOAD_PATH.push File.expand_path('../../lib', __FILE__)
require 'phase_shift'

runner = PhaseShift::Runner.new
runner.run
