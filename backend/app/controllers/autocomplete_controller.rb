# frozen_string_literal: true

class AutocompleteController < ApplicationController
  def search
    if result_object.success?
      json_response(result_object.response[:result])
    else
      record_invalid("Unpermitted class name #{autocomplete_params[:class_name]}")
    end
  end

  private

  def result_object
    @result_object ||= AutocompleteInteractor.run(autocomplete_params)
  end

  def autocomplete_params
    params.permit(:class_name, :query)
  end
end
