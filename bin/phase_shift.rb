#!/usr/bin/env ruby
$:.push File.expand_path("../../lib", __FILE__)
require 'phase_shift'

runner = PhaseShift::Runner.new
runner.run
