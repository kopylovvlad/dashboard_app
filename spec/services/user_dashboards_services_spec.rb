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

  describe 'update' do
    it 'should update item' do
      # prepare
      item = FactoryBot.create(:user_dashboard, user: user)
      expect(UserDashboard.count).to eq(1)
      item.title = title2
      item.position = -12

      # action
      updated_item = UserDashboardsServices.new.update(item)

      # check
      expect(updated_item.valid?).to eq(true)
      expect(updated_item.user).to eq(user)
      expect(updated_item.title).to eq(title2)
      expect(updated_item.position).to eq(1)
      expect(UserDashboard.count).to eq(1)
    end

    it 'should return invalid item' do
      # prepare
      item = FactoryBot.create(:user_dashboard, user: user)
      expect(UserDashboard.count).to eq(1)
      item.title = ''

      # action
      updated_item = UserDashboardsServices.new.update(item)

      # check
      expect(updated_item.valid?).to eq(false)
      expect(updated_item.title).to eq('')
      expect(UserDashboard.first.title).to_not eq(item.title)
      expect(UserDashboard.count).to eq(1)
    end

    it 'should recalculate all positions' do
      # prepare
      FactoryBot.create_list(
        :user_dashboard,
        4,
        user: user
      )
      expect(UserDashboard.count).to eq(4)
      d1, d2, d3, d4 = UserDashboard.ordered

      # action
      d4.position = 2
      updated_item = UserDashboardsServices.new.update(d4)

      # check
      expect(updated_item.valid?).to eq(true)
      expect(UserDashboard.find(d1.id).position).to eq(1)
      expect(UserDashboard.find(d4.id).position).to eq(2)
      expect(UserDashboard.find(d2.id).position).to eq(3)
      expect(UserDashboard.find(d3.id).position).to eq(4)
    end
  end
end