require 'rails_helper'

RSpec.describe 'UserDashboards#edit', type: :request do
  let(:user1) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:user_dashboard, user: user1) }

  describe 'guest' do
    it 'should redirect' do
      # action
      get(edit_user_dashboard_path(item))

      # check
      redirect_to_sign_in
    end
  end

  describe 'authed user' do
    describe 'owner' do
      it 'should render page' do
        # prepare
        sign_in(user1)

        # action
        get(edit_user_dashboard_path(item))

        # check
        expect(response).to have_http_status(200)
      end
    end

    describe 'item does not exist' do
      it 'should return 404' do
        # prepare
        sign_in(user1)
        expect(UserDashboard.count).to eq(0)

        # action
        get(edit_user_dashboard_path('999'))

        # check
        expect(response).to have_http_status(404)
      end
    end

    describe 'someone else item' do
      it 'should return 404' do
        # prepare
        sign_in(FactoryBot.create(:user))

        # action
        get(edit_user_dashboard_path(item))

        # check
        expect(response).to have_http_status(404)
      end
    end
  end
end