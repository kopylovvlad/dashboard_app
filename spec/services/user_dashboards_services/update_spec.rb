require 'rails_helper'

RSpec.describe UserDashboardsServices, type: :model do
  let(:title1) { 'title 1' }
  let(:title2) { 'new_title' }
  let(:user) { FactoryBot.create(:user) }

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