# frozen_string_literal: true

# == Schema Information
#
# Table name: disciplines
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_disciplines_on_name  (name) USING gin
#

class Discipline < ApplicationRecord
  include Searchable
  # has_and_belongs_to_many :participants
  # belongs_to :bet
  validates_presence_of :name
end
