# frozen_string_literal: true

require "active_support/concern"

# Actual module to extend the active record

# https://stackoverflow.com/questions/2328984/rails-extending-activerecordbase
module ActiveRecordExtension
  extend ActiveSupport::Concern

  class_methods do
    def memoized_sample_id
      var = "@_ids"
      instance_variable_set(var, instance_variable_get(var) || ids).sample
    end
  end
end

ActiveRecord::Base.public_send(:include, ActiveRecordExtension)
