require "bundler/setup"
require "rack/test"
require 'factory_bot'
require "rpc_off_rails"

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods

  def app
    described_class 
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include RSpecMixin 
  config.before(:suite) do
    FactoryBot.find_definitions
  end
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
