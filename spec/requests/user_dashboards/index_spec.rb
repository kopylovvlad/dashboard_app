require 'rails_helper'

RSpec.describe 'UserDashboards#index', type: :request do
  describe 'guest' do
    it 'should redirect' do
      # action
      get user_dashboards_path

      # check
      redirect_to_sign_in
    end
  end

  describe 'authed user' do
    describe 'has data' do
      it 'should see own dashboards' do
        # prepare
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:user)
        2.times do |i|
          FactoryBot.create(:user_dashboard, user: user1, title: "user1_d_#{i}")
        end
        FactoryBot.create(:user_dashboard, user: user2, title: "user2_d_1")
        sign_in(user1)

        # action
        get user_dashboards_path

        # check
        expect(response).to have_http_status(200)
        expect(response.body).to include('user1_d_0')
        expect(response.body).to include('user1_d_1')
        expect(response.body).to_not include('user2_d_1')
      end
    end

    describe 'without data' do
      it 'should render page' do
        # prepare
        sign_in(FactoryBot.create(:user))

        # action
        get user_dashboards_path

        # check
        expect(response).to have_http_status(200)
      end
    end
  end
end
