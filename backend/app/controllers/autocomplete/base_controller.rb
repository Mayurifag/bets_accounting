# frozen_string_literal: true

module Autocomplete
  class BaseController < ApplicationController
    # # TODO: move to controllers
    # if params[:autocomplete_bookmakers]
    #   @bookmakers = Bookmaker.autocomplete_name(params[:autocomplete_bookmakers])
    #   json_response(@bookmakers)
    # elsif params[:autocomplete_disciplines]
    #   @disciplines = Discipline.autocomplete_name(params[:autocomplete_disciplines])
    #   json_response(@disciplines)
    # elsif params[:autocomplete_events]
    #   @events = Event.autocomplete_name(params[:autocomplete_events])
    #   json_response(@events)
    # elsif params[:autocomplete_participants]
    #   @participants = Participant.autocomplete_name(params[:autocomplete_participants])
    #   json_response(@participants)
  end
end
