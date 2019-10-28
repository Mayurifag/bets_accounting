# frozen_string_literal: true

class AutocompleteController < ApplicationController
  def search
    if service_run.success?
      json_response(service_run.response[:result])
    else
      record_invalid("Unpermitted class name #{autocomplete_params[:class_name]}")
    end
  end

  private

  def service_run
    @service_run ||= AutocompleteService.run(autocomplete_params)
  end

  def autocomplete_params
    params.permit(:class_name, :query)
  end
end
