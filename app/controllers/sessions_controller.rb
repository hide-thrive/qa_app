class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to questions_path, flash: {success: 'ログインしました。'}
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path, flash: {success: 'ログアウトしました。'}
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end
end
