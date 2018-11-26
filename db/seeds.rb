# frozen_string_literal: true

user1 = User.find_by(email: 'john@example.com')
user2 = User.find_by(email: 'harry@example.com')

if user1.blank?
  user1 = FactoryBot.create(
    :user,
    email: 'john@example.com',
    first_name: 'John',
    last_name: 'Smith'
  )

  3.times do |_i|
    item = FactoryBot.build(
      :user_dashboard,
      user_id: user1.id
    )
    UserDashboardsServices.new.create(item)
  end
end

if user2.blank?
  user2 = FactoryBot.create(
    :user,
    email: 'harry@example.com',
    first_name: 'Harry',
    last_name: 'Johnson'
  )

  5.times do |_i|
    item = FactoryBot.build(
      :user_dashboard,
      user_id: user2.id
    )
    UserDashboardsServices.new.create(item)
  end
end

l = Logger.new(STDOUT)
l.info 'Seed finished'
l.info 'You have:'
l.info "#{User.count} users,"
l.info "#{UserDashboard.count} user_dashboards."
