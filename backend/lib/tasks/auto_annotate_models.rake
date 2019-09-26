# frozen_string_literal: true

# Annotate models on each run of rake db:migrate
Dir["#{Gem::Specification.find_by_name("annotate").full_gem_path}/**/tasks/**/*.rake"].each {|ext| load ext} if Rails.env.development?
