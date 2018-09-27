class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    uid = params[:session][:uid]
    password = params[:session][:password]

    if login(uid, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to user_create_commit_path(@user)
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def login(uid, password)
    # ToDo　find_or_create_byが必要か確認する
    @user = User.find_or_create_by(uid: uid)
    if @user.save && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
end
