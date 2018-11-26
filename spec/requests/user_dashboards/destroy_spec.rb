require 'rails_helper'

RSpec.describe 'UserDashboards#destroy', type: :request do
  describe 'guest' do
    it 'should redirect'
  end

  describe 'authed user' do
    it 'should delete item'

    describe 'someone else item' do
      it 'should not delete item'
    end
  end
end