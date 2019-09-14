# frozen_string_literal: true

class BetParamsTransformationHandler < ApplicationHandler
  def call
    if object.has_key?(:choice1)
      if object[:choice1].present?
        choice1 = Participant.find_or_create_by(name: object[:choice1])
        object[:choice1_id] = choice1.id
      end
      object.delete(:choice1)
    end

    if object.has_key?(:result_variant)
      if object[:result_variant].present?
        result_variant = ResultVariant.find_by(name: object[:result_variant])
        object[:result_variant_id] = result_variant&.id
      end
      object.delete(:result_variant)
    end

    if object.has_key?(:choice2)
      if object[:choice2].present?
        choice2 = Participant.find_or_create_by(name: object[:choice2])
        object[:choice2_id] = choice2.id
      end
      object.delete(:choice2)
    end

    if object.has_key?(:discipline)
      if object[:discipline].present?
        discipline = Discipline.find_or_create_by(name: object[:discipline])
        object[:discipline_id] = discipline.id
      end
      object.delete(:discipline)
    end

    if object.has_key?(:bet_type)
      bet_type = BetType.find_or_create_by(name: object[:bet_type])
      object.delete(:bet_type)
      object[:bet_type_id] = bet_type.id
    end

    if object.has_key?(:bookmaker)
      bookmaker = Bookmaker.find_or_create_by(name: object[:bookmaker])
      object.delete(:bookmaker)
      object[:bookmaker_id] = bookmaker.id
    else
      object[:bookmaker_id] = Bookmaker.other_id
    end

    object
  end
end
