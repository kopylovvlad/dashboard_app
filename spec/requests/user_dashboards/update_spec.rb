require 'rails_helper'

RSpec.describe 'UserDashboards#update', type: :request do
  let(:user1) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:user_dashboard, user: user1) }

  describe 'guest' do
    it 'should redirect' do
      # action
      patch(
        user_dashboard_path(item),
        params: {
          user_dashboard: {
            title: 'new_title'
          }
        }
      )

      # check
      redirect_to_sign_in
    end
  end

  describe 'authed user' do
    describe 'valid data' do
      it 'should update item' do
        # prepare
        item
        sign_in(user1)
        expect(UserDashboard.count).to eq(1)
        title = 'one_new_title'
        expect(UserDashboard.first.title).to_not eq(title)

        # action
        patch(
          user_dashboard_path(item),
          params: {
            user_dashboard: {
              title: title
            }
          }
        )

        # check
        expect(UserDashboard.count).to eq(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(user_dashboards_path)
        expect(UserDashboard.first.title).to eq(title)
      end
    end

    describe 'invalid data' do
      it 'should not update item' do
        # prepare
        title = item.title
        sign_in(user1)
        expect(UserDashboard.count).to eq(1)

        # action
        patch(
          user_dashboard_path(item),
          params: {
            user_dashboard: {
              title: ''
            }
          }
        )

        # check
        expect(UserDashboard.count).to eq(1)
        expect(response).to have_http_status(200)
        expect(UserDashboard.first.title).to eq(title)
      end
    end

    describe 'someone else item' do
      it 'should return 404' do
        # prepare
        item
        sign_in(FactoryBot.create(:user))
        expect(UserDashboard.count).to eq(1)
        title = 'one_new_title'
        expect(UserDashboard.first.title).to_not eq(title)

        # action
        patch(
          user_dashboard_path(item),
          params: {
            user_dashboard: {
              title: title
            }
          }
        )

        # check
        expect(UserDashboard.count).to eq(1)
        expect(response).to have_http_status(404)
        expect(UserDashboard.first.title).to_not eq(title)
      end
    end
  end
end