# frozen_string_literal: true

require "active_support/concern"

# https://stackoverflow.com/questions/2328984/rails-extending-activerecordbase
module ActiveRecordExtension
  extend ActiveSupport::Concern

  class_methods do
    def memoized_sample_id
      instance_variable_set("@_ids", instance_variable_get("@_ids") || ids).sample
    end
  end
end

ActiveRecord::Base.public_send(:include, ActiveRecordExtension)
