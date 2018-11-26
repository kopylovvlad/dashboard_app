require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe '#new' do
    describe 'guest' do
      it 'should work' do
        # action
        get(new_user_registration_path)

        # check
        expect(response).to have_http_status(200)
      end
    end

    describe 'authed user' do
      it 'should redirect' do
        # prepare
        sign_in(user)

        # action
        get(new_user_registration_path)

        # check
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#edit' do
    describe 'guest' do
      it 'should redirect' do
        # action
        get(edit_user_registration_path)

        # check
        redirect_to_sign_in
      end
    end

    describe 'authed user' do
      it 'should work' do
        # prepare
        sign_in(user)

        # action
        get(edit_user_registration_path)

        # check
        expect(response).to have_http_status(200)
      end
    end
  end

  describe '#update' do
    describe 'guest' do
      it 'should redirect' do
        # action
        patch(
          user_registration_path,
          params: {
            user: {
              first_name: 'john'
            }
          }
        )

        # check
        redirect_to_sign_in
      end
    end

    describe 'authed user' do
      describe 'valid data' do
        it 'should update profile' do
          # prepare
          sign_in(user)
          name = 'iamjohn'
          expect(user.first_name).to_not eq(name)

          # action
          patch(
            user_registration_path,
            params: {
              user: {
                email: user.email,
                first_name: name,
                last_name: user.last_name,
                current_password: '12345678'
              }
            }
          )

          # check
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(root_path)
          expect(User.find(user.id).first_name).to eq(name)
        end
      end

      describe 'invalid data' do
        it 'should return error' do
          # prepare
          sign_in(user)
          email = user.email

          # action
          patch(
            user_registration_path,
            params: {
              user: {
                email: ''
              }
            }
          )

          # check
          expect(response).to have_http_status(200)
          expect(User.find(user.id).email).to eq(email)
        end
      end
    end
  end
end
