# frozen_string_literal: true

# Abstract application record. Use /lib to extend it!
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
