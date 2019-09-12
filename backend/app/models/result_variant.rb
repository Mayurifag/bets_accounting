# frozen_string_literal: true

# == Schema Information
#
# Table name: result_variants
#
#  id   :bigint(8)        not null, primary key
#  name :string           not null
#

class ResultVariant < ApplicationRecord
  validates_presence_of :name

  # TODO: refactor ids from code: no need to have magic numbers etc
end
