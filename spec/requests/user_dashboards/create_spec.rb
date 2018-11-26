require 'rails_helper'

RSpec.describe 'UserDashboards#create', type: :request do
  describe 'guest' do
    it 'should redirect' do
      # action
      post(
        user_dashboards_path,
        params: {
          title: 'title'
        }
      )

      # check
      redirect_to_sign_in
    end
  end

  describe 'authed user' do
    describe 'valid data' do
      it 'should create item' do
        # prepare
        user = FactoryBot.create(:user)
        expect(UserDashboard.count).to eq(0)
        sign_in(user)

        # action
        post(
          user_dashboards_path,
          params: {
            user_dashboard: {
              title: 'title'
            }
          }
        )

        # check
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(user_dashboards_path)
        expect(UserDashboard.count).to eq(1)
        expect(UserDashboard.first.title).to eq('title')
      end
    end

    describe 'invalid data' do
      it 'should not create item' do
        # prepare
        user = FactoryBot.create(:user)
        expect(UserDashboard.count).to eq(0)
        sign_in(user)

        # action
        post(
          user_dashboards_path,
          params: {
            user_dashboard: {
              title: ''
            }
          }
        )

        # check
        expect(response).to have_http_status(200)
        expect(UserDashboard.count).to eq(0)
      end
    end
  end
end