# frozen_string_literal: true

# UserDashboardsController
class UserDashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_dashboard, only: %i[edit update destroy]

  def index
    @user_dashboards = current_user
                       .user_dashboards
                       .ordered
                       .paginate(page: params[:page])
  end

  def new
    @user_dashboard = UserDashboard.new
  end

  def edit; end

  def create
    item = current_user.user_dashboards.new(user_dashboard_params)
    @user_dashboard = UserDashboardsServices.new.create(item)
    if @user_dashboard.valid?
      redirect_to(
        user_dashboards_path,
        notice: 'User dashboard was successfully created.'
      )
    else
      render :new
    end
  end

  def update
    @user_dashboard.assign_attributes(user_dashboard_params)
    @user_dashboard = UserDashboardsServices.new.update(@user_dashboard)
    if @user_dashboard.valid?
      redirect_to(
        user_dashboards_path,
        notice: 'User dashboard was successfully updated.'
      )
    else
      render :edit
    end
  end

  def destroy
    UserDashboardsServices.new.destroy(@user_dashboard)
    redirect_to(
      user_dashboards_path,
      notice: 'User dashboard was successfully destroyed.'
    )
  end

  private

  def set_user_dashboard
    @user_dashboard = current_user.user_dashboards.find(params[:id])
  end

  def user_dashboard_params
    params.require(:user_dashboard).permit(:title, :position)
  end
end
