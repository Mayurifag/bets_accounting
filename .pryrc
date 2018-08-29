if Rails.env.development? || Rails.env.test?
  # This introduces the `table` statement
  extend Hirb::Console
else
  old_prompt = Pry.config.prompt
  env = Pry::Helpers::Text.red(Rails.env.upcase)
  Pry.config.prompt = [
    proc {|*a| "#{env} #{old_prompt.first.call(*a)}"},
    proc {|*a| "#{env} #{old_prompt.second.call(*a)}"},
  ]
end
