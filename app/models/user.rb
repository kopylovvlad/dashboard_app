# frozen_string_literal: true

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

# User model
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :user_dashboards, dependent: :destroy

  def full_name
    str = [first_name, last_name].join(' ')
    str.strip
  end
end
