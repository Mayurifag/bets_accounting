# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  Hirb.enable
  Pry.config.print = proc do |output, value, pry|
    Hirb::View.view_or_page_output(value) || Pry::DEFAULT_PRINT.call(output, value, pry)
  end
end

Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
