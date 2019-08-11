# == Schema Information
#
# Table name: disciplines
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Discipline < ApplicationRecord
  # has_and_belongs_to_many :participants
  # belongs_to :bet
  include PgSearch
  pg_search_scope :autocomplete_name, against: :name,
                                      using: { tsearch: { prefix: true } },
                                      order_within_rank: 'created_at ASC'
  validates_presence_of :name
end
