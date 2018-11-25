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

require 'rails_helper'

RSpec.describe UserDashboard, type: :model do
  describe 'shoulda' do
    it { should validate_presence_of(:title) }
    it { should belong_to(:user) }
    it { should validate_uniqueness_of(:title).scoped_to(:user_id) }
  end

  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }

  describe 'scopes' do
    def prepare_data
      FactoryBot.create_list(
        :user_dashboard,
        3,
        user: user1
      )

      FactoryBot.create_list(
        :user_dashboard,
        2,
        user: user2
      )

      expect(UserDashboard.count).to eq(5)
      expect(user1.user_dashboards.count).to eq(3)
      expect(user2.user_dashboards.count).to eq(2)
    end

    describe 'all_by_user' do
      it 'should work' do
        # prepare
        prepare_data

        # action
        d1 = UserDashboard.all_by_user(user1).count
        d2 = UserDashboard.all_by_user(user2).count

        # check
        expect(d1).to eq(3)
        expect(d2).to eq(2)
      end
    end

    describe 'siblings' do
      it 'should work (case 1)' do
        # prepare
        prepare_data
        d1, d2, d3 = user1.user_dashboards

        # action
        s1 = UserDashboard.siblings(d1)
        s2 = UserDashboard.siblings(d2)
        s3 = UserDashboard.siblings(d3)

        # check
        expect(s1.size).to eq(2)
        s1.each { |i| expect([d2, d3]).to include(i) }

        expect(s2.size).to eq(2)
        s2.each { |i| expect([d1, d3]).to include(i) }

        expect(s3.size).to eq(2)
        s3.each { |i| expect([d1, d2]).to include(i) }
      end

      it 'should work (case 2)' do
        # prepare
        prepare_data
        d1, d2 = user2.user_dashboards

        # action
        s1 = UserDashboard.siblings(d1)
        s2 = UserDashboard.siblings(d2)

        # check
        expect(s1.size).to eq(1)
        expect(s1.first.id).to eq(d2.id)

        expect(s2.size).to eq(1)
        expect(s2.first.id).to eq(d1.id)
      end
    end
  end
end
