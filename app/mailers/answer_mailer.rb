class AnswerMailer < ApplicationMailer

  def answer_email
    @user = params[:user]
    @question = params[:question]
    @answer = params[:answer]
    mail(
      subject: '質問回答',
      to: @user.email,
      from: 'from@example.com'
    )
  end

end
