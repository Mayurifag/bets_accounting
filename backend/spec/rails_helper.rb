# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'simplecov'
if ENV['TEST_ENV_NUMBER'] # parallel specs
  require 'simplecov-console'
  SimpleCov.formatter = SimpleCov::Formatter::Console
  SimpleCov.at_exit do
    result = SimpleCov.result
    result.format! if ParallelTests.number_of_running_processes <= 1
  end
end
SimpleCov.start 'rails'

# lib is required due to simplecov coverage
Dir[Rails.root.join('lib', '*.rb')].each { |f| load f }
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

require 'database_rewinder'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include RequestSpecHelper, type: :request

  config.before(:suite) do
    DatabaseRewinder.clean_all
  end

  config.after(:each) do
    DatabaseRewinder.clean
  end

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.silence_filter_announcements = true if ENV['TEST_ENV_NUMBER']
end
