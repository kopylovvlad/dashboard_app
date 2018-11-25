# Here is updating position logic
class UserDashboardsServices
  def create(dashboard)
    position_limit = UserDashboard.all_by_user(dashboard.user_id).count + 1
    create_or_update(dashboard, position_limit)
  end

  def update(dashboard)
    position_limit = UserDashboard.all_by_user(dashboard.user_id).count
    create_or_update(dashboard, position_limit)
  end

  private

  def create_or_update(dashboard, position_limit)
    if dashboard.position.nil? || dashboard.position <= 0
      dashboard.position = position_limit
    end
    if dashboard.position > position_limit
      dashboard.position = position_limit
    end

    if dashboard.valid?
      reorder_items(dashboard)
    end
    dashboard
  end

  def reorder_items(dashboard)
    current_position = dashboard.position
    i = 1
    ActiveRecord::Base.transaction do
      dashboard.save
      UserDashboard.siblings(dashboard).each do |item|
          i += 1 if i == current_position
          item.update_attributes(position: i)
          i += 1
      end
    end
  end
end
