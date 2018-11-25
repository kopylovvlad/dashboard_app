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
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email(20) }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
