# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  # This introduces the `table` statement
  extend Hirb::Console
end

Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
