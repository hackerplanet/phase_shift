RSpec.configure do |config|
  config.alias_example_to :fit, focus: true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end
