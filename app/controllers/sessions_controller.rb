class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "#{@user.name}さんがログインしました"
      redirect_to @user
    else
      flash[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:info] = "ログアウトしました"
    redirect_to root_path
  end
end