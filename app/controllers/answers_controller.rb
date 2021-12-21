class AnswersController < ApplicationController
  

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(user_id: current_user.id, content: params[:answer][:content])
    @user = User.where(id: @question.user).where(id: @answer.user).where.not(id: current_user.id).distinct
    binding.pry
    if @answer.save
      @user.each do |user|
        AnswerMailer.with(question: @question, answer: @answer, user: user).answer_email.deliver_now
      end
      redirect_to question_path(@question), flash: {success: '回答をしました。'}
    else
      flash.now[:danger] = "回答に失敗しました。"
      render "questions/show"
    end
  end

  private
    def answer_params
      params.require(:answer).permit(:content)
    end
end
