# frozen_string_literal: true

class AutocompleteController < ApplicationController
  # TODO: move this to AutocompleteHandler?
  ALLOWED_AUTOCOMPLETE_CLASSES = %w[Bookmaker Discipline Event Participant].freeze
  private_constant :ALLOWED_AUTOCOMPLETE_CLASSES

  def search
    @class_name = autocomplete_params[:class_name]
    if ALLOWED_AUTOCOMPLETE_CLASSES.include? @class_name
      autocomplete_results = @class_name.constantize.autocomplete_name(autocomplete_params[:query])
      json_response autocomplete_results
    else
      record_invalid("Unpermitted class name #{@class_name}")
    end
  end

  private

  def autocomplete_params
    params.permit(:class_name, :query)
  end
end
