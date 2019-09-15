# frozen_string_literal: true

class BetParamsTransformationHandler < ApplicationHandler
  FIELDS = [
    [:choice1, :find_or_create_by],
    [:choice2, :find_or_create_by],
    [:bookmaker, :find_or_create_by],
    [:discipline, :find_or_create_by],
    [:bet_type, :find_by],
    [:result_variant, :find_by]
  ].freeze

  def call
    FIELDS.each do |field_name, method_for_class|
      next unless object.has_key?(field_name)

      transform_field_to_field_id(field_name, method_for_class)
    end

    object
  end

  private

  def transform_field_to_field_id(field, method)
    if object[field].present?
      field_id_symbol = (field.to_s + '_id').to_sym
      model_object = find_model_object_by_name(field, method)
      object[field_id_symbol] = model_object&.id
    end

    object.delete(field)
  end

  def find_model_object_by_name(field, method)
    klass(field).public_send(method, { name: object[field] })
  end

  def klass(name)
    # TODO: think about how to define this
    return Participant if name =~ /choice/

    name.to_s.classify.constantize
  end
end
