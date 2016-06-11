require 'rspec'
require 'rspec/core/formatters/base_text_formatter'

class OcularDryRunFormatter < RSpec::Core::Formatters::BaseTextFormatter
  ::RSpec::Core::Formatters.register self, :dump_summary
end

RSpec.configure do |config|
  config.before(:all) { raise 'Fail each test immediately' }
end
