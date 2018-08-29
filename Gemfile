ruby File.read(File.expand_path('.ruby-version', __dir__)).chomp

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Rails
gem 'rails', '>= 5.2.0'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
gem 'pg_search'

# Use Puma as the app server
gem 'puma', '~> 3.0'

# Common
gem 'awesome_rails_console'
gem 'bootsnap', require: false # fast boot
gem 'oj', '~> 2.16.1'
gem 'rollbar'
gem 'slim', '~> 4.0'
gem 'webpacker', '~> 3.5' # Webpacker

# Questionable
# gem 'money-rails' # used in models
# gem 'draper'
gem 'faker' # needed for seeds.rb at least

group :development, :test do
  gem 'byebug', platform: :mri # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'hirb'
  gem 'hirb-unicode-steakknife'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'rspec-rails', '~> 3.5'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'listen', '~> 3.0.5'
  gem 'ordinare', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'strong_migrations'
end

group :development, :ci do
  gem 'capistrano', '~> 3.11', require: false
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rails-console', require: false
  gem 'capistrano-rbenv', '~> 2.1', require: false
  gem 'capistrano-yarn', require: false
  gem 'capistrano3-nginx', '~> 2.1', require: false
  gem 'capistrano3-puma', require: false
end

group :ci do
  gem 'pronto'
  gem 'pronto-brakeman', require: false
  gem 'pronto-fasterer', require: false
  gem 'pronto-flay', require: false
  gem 'pronto-reek', require: false
  gem 'pronto-rubocop', require: false
  # waiting for ~> 4
  # gem 'pronto-slim', require: false
end

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'jbuilder', '~> 2.5' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
