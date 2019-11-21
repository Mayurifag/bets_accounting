# frozen_string_literal: true

# Autcomplete for participants, etc. when bet is creating for better UX.
#
# POST /autocomplete
# {
#   class_name: "Participant" # defined in ALLOWED_AUTOCOMPLETE_CLASSES of AutocompleteInteractor
#   query: "huy" # the thing you want to autocomplete with requested class names
# }
class AutocompleteController < ApplicationController
  def search
    if service_result_object.success?
      json_response(service_result_object.response[:result])
    else
      record_invalid("Unpermitted class name #{autocomplete_params[:class_name]}")
    end
  end

  private

  def service_result_object
    @service_result_object ||= AutocompleteInteractor.run(autocomplete_params)
  end

  def autocomplete_params
    params.permit(:class_name, :query)
  end
end
