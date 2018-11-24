# == Schema Information
#
# Table name: user_dashboards
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  title      :string           default(""), not null
#  position   :integer          default(0)
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

require 'rails_helper'

RSpec.describe UserDashboard, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
