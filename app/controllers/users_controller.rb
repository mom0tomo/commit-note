class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.latest_sign_in_at = Time.zone.now

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to user_months_path(@user)
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:uid, :password, :password_confirmation)
    end
end
