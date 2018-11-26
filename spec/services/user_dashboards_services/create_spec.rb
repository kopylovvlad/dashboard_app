require 'rails_helper'

RSpec.describe UserDashboardsServices, type: :model do
  let(:title1) { 'title 1' }
  let(:title2) { 'new_title' }
  let(:user) { FactoryBot.create(:user) }

  describe 'create' do
    it 'should create a dashboard' do
      # prepare
      expect(UserDashboard.count).to eq(0)
      item = UserDashboard.new(
        user: user,
        title: title1,
        position: 1
      )

      # action
      created_item = UserDashboardsServices.new.create(item)

      # check
      expect(created_item.valid?).to eq(true)
      expect(created_item.user).to eq(user)
      expect(created_item.title).to eq(title1)
      expect(UserDashboard.count).to eq(1)
    end

    it 'should return invalid item' do
      # prepare
      expect(UserDashboard.count).to eq(0)
      item = UserDashboard.new(user: user)

      # action
      created_item = UserDashboardsServices.new.create(item)

      # check
      expect(created_item.valid?).to eq(false)
      expect(created_item.errors.keys.size).to be > 0
      expect(UserDashboard.count).to eq(0)
    end

    it 'should update position' do
      # prepare
      expect(UserDashboard.count).to eq(0)
      item = UserDashboard.new(
        user: user,
        title: title1,
        position: 99
      )

      # action
      created_item = UserDashboardsServices.new.create(item)

      # check
      expect(created_item.valid?).to eq(true)
      expect(created_item.user).to eq(user)
      expect(created_item.title).to eq(title1)
      expect(UserDashboard.count).to eq(1)
    end

    it 'should recalculate all positions' do
      # prepare
      d1 = FactoryBot.create(
        :user_dashboard,
        user: user,
        position: 1
      )
      d2 = FactoryBot.create(
        :user_dashboard,
        user: user,
        position: 2
      )
      item = UserDashboard.new(
        user: user,
        title: title1,
        position: 1
      )
      expect(UserDashboard.count).to eq(2)

      # action
      created_item = UserDashboardsServices.new.create(item)

      # check
      expect(created_item.valid?).to eq(true)
      expect(UserDashboard.count).to eq(3)
      expect(created_item.position).to eq(1)
      expect(UserDashboard.find(d1.id).position).to eq(2)
      expect(UserDashboard.find(d2.id).position).to eq(3)
    end
  end
end