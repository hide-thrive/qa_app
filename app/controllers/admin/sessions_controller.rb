class Admin::SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password]) && user.admin?
      session[:user_id] = user.id
      redirect_to admin_users_path, flash: {success: "ログインしました。" }
    else
      flash.now[:destroy] = "ログインに失敗しました。"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_url, flash: {danger: 'ログアウトしました。'}
  end

  private
    def session_params
      params.require(:admin_session).permit(:email, :password)
    end
end
