# frozen_string_literal: true

# TODO: Move this to form object
#
# Transforms the class names to its ids for database handling further.
# Creates db entry if there is no such name or so
class BetParamsTransformationHandler < ApplicationHandler
  # TODO: find or create check with similarity percent
  FIELDS = [
    %i[choice1 find_or_create_by],
    %i[choice2 find_or_create_by],
    %i[bookmaker find_or_create_by],
    %i[discipline find_or_create_by],
    %i[bet_type find_by],
    %i[result_variant find_by],
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
    move_field_value_to_ids(field, method) if object.fetch(field).present?
    object.delete(field)
  end

  def move_field_value_to_ids(field, method)
    db_entry = find_entry_by_its_name(field, method)
    return if db_entry.blank?

    object[field_as_hash_key_field_id(field)] = db_entry.id
  end

  def field_as_hash_key_field_id(field)
    field_id_string = field.to_s + "_id"
    field_id_string.to_sym
  end

  def find_entry_by_its_name(field, method)
    klass(field).public_send(method, name: object[field])
  end

  def klass(name)
    # TODO: think about how to define this
    return Participant if %r{choice}.match?(name)

    name.to_s.classify.constantize
  end
end
