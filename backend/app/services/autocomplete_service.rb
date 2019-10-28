# frozen_string_literal: true

class AutocompleteService < BaseService
  def initialize(params)
    @params = params
  end

  # TODO: another class specially for bets
  # TODO: Bet.reflect_on_all_associations
  ALLOWED_AUTOCOMPLETE_CLASSES = %w[Bookmaker Discipline Event Participant].freeze
  private_constant :ALLOWED_AUTOCOMPLETE_CLASSES

  def call
    return fail! unless ALLOWED_AUTOCOMPLETE_CLASSES.include? @params[:class_name]

    klass = @params[:class_name].constantize
    result = klass.autocomplete_name(@params[:query])

    success!(result: result)
  end
end
