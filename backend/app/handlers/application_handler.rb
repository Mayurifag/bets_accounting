# frozen_string_literal: true

# Base class for handlers
class ApplicationHandler
  delegate_missing_to :@object
  attr_accessor :object

  def initialize(object)
    @object = object
  end
end
