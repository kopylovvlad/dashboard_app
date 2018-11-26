require 'rails_helper'

RSpec.describe UserDashboardsServices, type: :model do
  let(:user) { FactoryBot.create(:user) }

  def prepare_data
    4.times do |_i|
      item = FactoryBot.build(:user_dashboard, user: user)
      UserDashboardsServices.new.create(item)
    end
    expect(UserDashboard.count).to eq(4)
  end

  describe 'destroy' do
    it 'should destroy one item' do
      # prepare
      prepare_data
      item = user.user_dashboards.all.first

      # action
      UserDashboardsServices.new.destroy(item)

      # check
      expect(UserDashboard.count).to eq(3)
    end

    it 'should recalculate all position (case 1)' do
      # prepare
      prepare_data
      i1, i2, i3, i4 = user.user_dashboards.ordered

      # action
      UserDashboardsServices.new.destroy(i1)

      # check
      expect(UserDashboard.find(i2.id).position).to eq(1)
      expect(UserDashboard.find(i3.id).position).to eq(2)
      expect(UserDashboard.find(i4.id).position).to eq(3)
    end

    it 'should recalculate all position (case 2)' do
      # prepare
      prepare_data
      i1, i2, i3, i4 = user.user_dashboards.ordered

      # action
      UserDashboardsServices.new.destroy(i2)

      # check
      expect(UserDashboard.find(i1.id).position).to eq(1)
      expect(UserDashboard.find(i3.id).position).to eq(2)
      expect(UserDashboard.find(i4.id).position).to eq(3)
    end
  end
end