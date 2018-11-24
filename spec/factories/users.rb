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

FactoryBot.define do
  factory :user do
    
  end
end
