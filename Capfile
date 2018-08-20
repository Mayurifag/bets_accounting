# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# https://github.com/capistrano/rails/blob/master/README.md
require 'capistrano/rails'

# Load the SCM plugin appropriate to your project:
#
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:

require 'capistrano/puma'
require 'capistrano/rbenv'
require 'capistrano/yarn'
require 'capistrano/bundler'
require 'capistrano/rails/console'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
