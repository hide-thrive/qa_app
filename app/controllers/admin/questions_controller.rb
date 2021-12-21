class Admin::QuestionsController < ApplicationController
  before_action :admin_user

  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page])
  end

  private
    def admin_user
      redirect_to root_path, warning: '権限がありません' unless current_user.admin?
    end
end
