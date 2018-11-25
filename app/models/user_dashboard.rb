# == Schema Information
#
# Table name: user_dashboards
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  title      :string           default(""), not null
#  position   :integer          default(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_dashboards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class UserDashboard < ApplicationRecord
  scope :ordered, -> { reorder(position: :asc) }
  scope :siblings,  ->(i) { all_by_user(i.user_id).where.not(id: i.id).ordered }
  scope :all_by_user,  ->(id) { where(user_id: id).ordered }
  belongs_to :user

  validates :title, presence: true
  validates :title, uniqueness: { scope: :user_id }

  self.per_page = 5
end
