class QuestionsController < ApplicationController
  before_action :set_question, only: %i(show edit update destroy)

  def index
    @q = Question.ransack(params[:q])
    # @questions = @q.result(distinct: true).page(params[:page])
    
    if params[:is_solved] == 'false'
      @questions = Question.where(is_solved: false).page(params[:page])
    elsif params[:is_solved] == 'true'
      @questions = Question.where(is_solved: true).page(params[:page])
    else
      @questions = Question.page(params[:page])
    end
  end

  def show
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      User.where.not(id: current_user.id).each do |user|
        QuestionMailer.with(user: user, question: @question, question_user: @question.user.name).creation_email.deliver_now
      end
      redirect_to question_path(@question), flash: {success: "タスク「#{@question.title}」を登録しました。"} 
    else
      flash[:alert] = '登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    @question.update!(question_params)
    redirect_to questions_url, flash: {success: "質問「#{@question.title}」を更新しました"}
  end

  def destroy
    @question.destroy
    redirect_to questions_url, flash: {warning: "質問「#{@question.title}」を削除しました。"}
  end


  private

    def question_params
      params.require(:question).permit(:title, :content, :is_solved)
    end

    def set_question
      @question = Question.find(params[:id])
    end
end
