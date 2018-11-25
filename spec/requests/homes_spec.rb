require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe 'root path' do
    describe 'guest' do
      it "should work" do
        # action
        get root_path

        # check
        expect(response).to have_http_status(200)
      end
    end

    describe 'authed user' do
      it "should work" do
        # prepare
        sign_in(FactoryBot.create(:user))

        # action
        get root_path

        # check
        expect(response).to have_http_status(200)
      end
    end
  end

  describe '404 page' do
    it "should work" do
      # action
      get('/not_found_page')

      # check
      expect(response).to have_http_status(404)
    end
  end
end
