# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           default(""), not null
#  name            :string
#  password_digest :string
#  username        :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'valid?' do
    context 'when everything is blank' do
      subject { described_class.new }

      it { is_expected.not_to be_valid }
    end
  end
end
