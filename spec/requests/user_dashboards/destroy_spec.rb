require 'rails_helper'

RSpec.describe 'UserDashboards#destroy', type: :request do
  let(:user1) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:user_dashboard, user: user1) }

  describe 'guest' do
    it 'should redirect' do
      # action
      delete(user_dashboard_path(item))

      # check
      redirect_to_sign_in
    end
  end

  describe 'authed user' do
    it 'should delete item' do
      # prepare
      item
      sign_in(user1)
      expect(UserDashboard.count).to eq(1)

      # action
      delete(user_dashboard_path(item))

      # check
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(user_dashboards_path)
      expect(UserDashboard.count).to eq(0)
    end

    describe 'item does not exist' do
      it 'render 404' do
        # prepare
        sign_in(user1)
        expect(UserDashboard.count).to eq(0)

        # action
        delete(user_dashboard_path('999'))

        # check
        expect(response).to have_http_status(404)
      end
    end

    describe 'someone else item' do
      it 'should render 404' do
        # prepare
        item
        sign_in(FactoryBot.create(:user))
        expect(UserDashboard.count).to eq(1)

        # action
        delete(user_dashboard_path(item))

        # check
        expect(response).to have_http_status(404)
        expect(UserDashboard.count).to eq(1)
      end
    end
  end
end