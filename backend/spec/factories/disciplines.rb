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

FactoryBot.define do
  factory :discipline do
    name { Faker::Esport.game }
  end
end
