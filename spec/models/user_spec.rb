# == Schema Information
#
# Table name: users
#
#  id                  :bigint(8)        not null, primary key
#  first_name          :string           default(""), not null
#  last_name           :string           default(""), not null
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'shoulda' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should have_many(:user_dashboards).dependent(:destroy) }
  end
end
