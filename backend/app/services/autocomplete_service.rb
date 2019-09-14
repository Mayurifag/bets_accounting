class AutocompleteService < BaseService
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  ALLOWED_AUTOCOMPLETE_CLASSES = %w[Bookmaker Discipline Event Participant].freeze
  private_constant :ALLOWED_AUTOCOMPLETE_CLASSES

  def call
    if ALLOWED_AUTOCOMPLETE_CLASSES.include? params[:class_name]
      result = params[:class_name].constantize.autocomplete_name(params[:query])
      success = true
    else
      success = false
    end
    Result.new(result: result, success: success)
  end
end
