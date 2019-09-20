# frozen_string_literal: true

# == Schema Information
#
# Table name: participants
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_participants_on_name  (name) USING gin
#

FactoryBot.define do
  factory :participant do
    name { Faker::Esport.team }
  end
end
