require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe '#new' do
    it 'should work' do
      # action
      get new_user_session_path

      # check
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    describe 'valid data' do
      it 'should work' do
        # prepare
        email = 'justemail@tmail.com'
        password = '12345678'
        user = FactoryBot.create(
          :user,
          email: email,
          password: password
        )

        # action
        post(
          user_session_path,
          params: {
            user: {
              email: email,
              password: password
            }
          }
        )

        # check
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'invalid data' do
      it 'should redirect' do
        # prepare
        user = FactoryBot.create(:user)

        # action
        post(
          user_session_path,
          params: {
            user: {
              email: '',
              password: ''
            }
          }
        )

        # check
        expect(response).to have_http_status(200)
      end
    end
  end

  describe '#destroy' do
    it 'should work' do
      # prepare
      sign_in(FactoryBot.create(:user))

      # action
      delete(destroy_user_session_path)

      # check
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end
  end
end
