class UsersController < ApplicationController
  skip_before_action :login_required, only: %i(new create)
  before_action :set_user, only: %i(show edit update destroy)

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, flash: {success: "ユーザ「#{@user.name}」を登録しました。"}
    else
      flash.now[:danger] = "ユーザー登録に失敗しました。"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
      if @user.update(user_params)
        redirect_to user_path(@user), flash: {success: "ユーザー情報を更新しました。"}
      else
        flash[:danger] = "ユーザーの更新に失敗しました。"
        render :edit
      end
  end

  def destroy
    @user.destroy
    redirect_to signup_url, flash: {warning: "ユーザ「#{@user.name}」を削除しました。"}
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
