# frozen_string_literal: true

require "oj"

Blueprinter.configure do |config|
  # default is JSON
  config.generator = Oj
end
