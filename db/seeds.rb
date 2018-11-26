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

  FactoryBot.create_list(
    :user_dashboard,
    3,
    user_id: user1.id
  )
end

if user2.blank?
  user2 = FactoryBot.create(
    :user,
    email: 'harry@example.com',
    first_name: 'Harry',
    last_name: 'Johnson'
  )

  FactoryBot.create_list(
    :user_dashboard,
    5,
    user_id: user2.id
  )
end

l = Logger.new(STDOUT)
l.info 'Seed finished'
l.info 'You have:'
l.info "#{User.count} users,"
l.info "#{UserDashboard.count} user_dashboards."
