# frozen_string_literal: true

class BetBlueprint < Blueprinter::Base
  FIELDS_WITH_NAMES = %i[choice1 choice2 discipline result_variant event
                         bet_type bookmaker].freeze

  identifier :id

  fields :coefficient, :outcome, :wager

  # TODO: is this fine
  field :profit do |bet|
    format('%0.02f', bet.profit) # if bet.profit.present?
  end

  FIELDS_WITH_NAMES.each do |attr|
    field attr do |bet|
      bet.public_send(attr)&.name
    end
  end
end
