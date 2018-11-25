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
  describe 'shoulda' do
    it { should validate_presence_of(:title) }
    it { should belong_to(:user) }
  end

  describe 'title' do
    describe 'uniqueness' do
      it 'should not be the same for a user' do
        # prepare
        user = FactoryBot.create(:user)
        title = 'my_dashboard'
        d1 = UserDashboard.create!(
            title: title,
            user: user
        )
        expect(user.user_dashboards.count).to eq(1)

        # action
        d2 = UserDashboard.new(
            title: title,
            user: user
        )

        # check
        expect(d2.valid?).to eq(false)
        expect(d2.save).to eq(false)
        expect(user.user_dashboards.count).to eq(1)
      end

      it 'should be uniq for a user' do
        # prepare
        user = FactoryBot.create(:user)
        title = 'my_dashboard1'
        title2 = 'my_dashboard2'
        d1 = UserDashboard.create!(
            title: title,
            user: user
        )
        expect(user.user_dashboards.count).to eq(1)

        # action
        d2 = UserDashboard.new(
            title: title2,
            user: user
        )

        # check
        expect(d2.valid?).to eq(true)
        expect(d2.save).to eq(true)
        expect(user.user_dashboards.count).to eq(2)
      end

      it 'should be uniq for few users' do
        # prepare
        expect(UserDashboard.count).to eq(0)
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:user)
        title = 'dashboard_title'
        d1 = UserDashboard.create!(
            title: title,
            user: user1
        )

        # action
        d2 = UserDashboard.new(
            title: title,
            user: user2
        )

        # check
        expect(d2.valid?).to eq(true)
        expect(d2.save).to eq(true)
        expect(UserDashboard.count).to eq(2)
      end
    end
  end
end
