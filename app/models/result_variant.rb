# == Schema Information
#
# Table name: result_variants
#
#  id   :bigint(8)        not null, primary key
#  name :string
#

class ResultVariant < ApplicationRecord
  validates_presence_of :name
end
