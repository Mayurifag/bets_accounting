# frozen_string_literal: true

# Service to check if params[:class_name] is able to autocomplete and return the
# result object if so. Needs params with :class_name and :query keys and strings
# for values.
class AutocompleteInteractor < BaseInteractor
  def initialize(params)
    @params = params
  end

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
