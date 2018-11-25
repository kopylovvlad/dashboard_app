class Ability
  include CanCan::Ability

  def initialize(user)
    if user.id.present?
      can [:manage], UserDashboard do |i|
        i.user_id == user.id
      end
    end
  end
end
