# frozen_string_literal: true

class AutocompleteController < ApplicationController
  def search
    autocomplete_call = AutocompleteService.new(autocomplete_params).call
    if autocomplete_call.success?
      json_response(autocomplete_call.result)
    else
      record_invalid("Unpermitted class name #{autocomplete_params[:class_name]}")
    end
  end

  private

  def autocomplete_params
    params.permit(:class_name, :query)
  end
end
