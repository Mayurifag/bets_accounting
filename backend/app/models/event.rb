# == Schema Information
#
# Table name: events
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  period     :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :autocomplete_name, against: :name,
                  using: {
                    tsearch: { prefix: true }
                  },
                  order_within_rank: 'created_at ASC'
  validates_presence_of :name
end
