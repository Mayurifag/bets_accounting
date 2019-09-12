# frozen_string_literal: true

class AutocompleteController < ApplicationController
  ALLOWED_AUTOCOMPLETE_CLASSES = %w[Bookmaker Discipline Event Participant].freeze
  private_constant :ALLOWED_AUTOCOMPLETE_CLASSES

  def search
    validate_class_name_param
    autocomplete_results = @class_name.constantize.autocomplete_name(autocomplete_params[:query])
    json_response autocomplete_results
  end

  private

  def validate_class_name_param
    @class_name = autocomplete_params[:class_name]
    return if ALLOWED_AUTOCOMPLETE_CLASSES.include? @class_name

    raise RecordInvalid.new(message: "Unpermitted #{@class_name}")
  end

  def autocomplete_params
    params.permit(:class_name, :query)
  end
end
