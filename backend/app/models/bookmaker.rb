# frozen_string_literal: true

# == Schema Information
#
# Table name: bookmakers
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_bookmakers_on_name  (name) USING gin
#

class Bookmaker < ApplicationRecord
  include Searchable

  validates_presence_of :name
end
