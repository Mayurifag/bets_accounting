# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  # This introduces the `table` statement
  extend Hirb::Console
end
