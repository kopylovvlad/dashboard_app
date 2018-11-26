# frozen_string_literal: true

# model for cancancan
class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.id.blank?

    can [:manage], UserDashboard do |i|
      i.user_id == user.id
    end
  end
end
