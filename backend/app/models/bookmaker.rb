# == Schema Information
#
# Table name: bookmakers
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bookmaker < ApplicationRecord
  include PgSearch
  pg_search_scope :autocomplete_name, against: :name,
                  using: {
                    tsearch: { prefix: true }
                  },
                  order_within_rank: 'created_at ASC'
  validates_presence_of :name

  def self.other_id
    # create for test suite
    find_or_create_by(name: 'Другая').id
  end
end
