# frozen_string_literal: true

class AutocompleteInteractor < BaseInteractor
  def initialize(params)
    @params = params
  end

  # TODO: another class specially for bets
  # TODO: Bet.reflect_on_all_associations
  ALLOWED_AUTOCOMPLETE_CLASSES = %w[Bookmaker Discipline Event Participant].freeze
  private_constant :ALLOWED_AUTOCOMPLETE_CLASSES

  def call
    return fail! if not_allowed_to_autocomplete_class?

    success!(result: autocomplete_variants)
  end

  private

  def not_allowed_to_autocomplete_class?
    !ALLOWED_AUTOCOMPLETE_CLASSES.include? @params[:class_name]
  end

  def klass
    @params[:class_name].constantize
  end

  def autocomplete_variants
    klass.autocomplete_name(@params[:query])
  end
end
