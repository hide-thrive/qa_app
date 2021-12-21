class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_url, flash: {success: "ユーザ「#{user.name}」を削除しました。"}
  end

  private
    def admin_user
      redirect_to root_path, warning: '権限がありません' unless current_user.admin?
    end
end
