# frozen_string_literal: true

RSpec.configure do |config|
  config.add_formatter 'Fuubar'
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.profile_examples = 4
  config.order = :random
  Kernel.srand config.seed
end
