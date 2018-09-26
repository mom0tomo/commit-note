class MonthsController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]

  def index
    @user = User.find(params[:user_id])
    @months = Month.all
    @month_id = Time.current.month
    @commits =  Commit.where(month_id: @month_id)
  end

  def show
    @user = User.find(params[:user_id])
    @months = Month.all
    @month = Month.find(params[:id])
    @month_id = @month.id
    @commits =  Commit.where(month_id: @month_id)
  end
end
