require 'rails_helper'

RSpec.describe 'UserDashboards#new', type: :request do
  describe 'guest' do
    it 'should redirect' do
      # action
      get new_user_dashboard_path

      # check
      redirect_to_sign_in
    end
  end

  describe 'authed user' do
    it 'should render page' do
      # prepare
      sign_in(FactoryBot.create(:user))

      # action
      get new_user_dashboard_path

      # check
      expect(response).to have_http_status(200)
    end
  end
end