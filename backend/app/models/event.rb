# frozen_string_literal: true

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
# Indexes
#
#  index_events_on_name  (name) USING gin
#

class Event < ApplicationRecord
  include Searchable

  validates_presence_of :name
end
