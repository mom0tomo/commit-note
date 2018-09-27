class MonthsController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]

  def index
    @user = current_user
    @months = Month.all
    @month_id = Time.current.month
    @this_month_commits =  Commit.where(user_id: @user.id, month_id: @month_id)
  end

  def show
    @user = current_user
    @months = Month.all
    @month = Month.find(params[:id])
    @month_id = @month.id
    @this_month_commits =  Commit.where(user_id: @user.id, month_id: @month_id)
  end
end
