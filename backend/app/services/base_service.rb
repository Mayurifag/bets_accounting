# frozen_string_literal: true

class BaseService
  class Result
    include ActiveModel::Model
    attr_accessor :success, :result
    alias success? success
  end
end
