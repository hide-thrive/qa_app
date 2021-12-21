class QuestionMailer < ApplicationMailer
  default from: 'form@example.com'
  
  def creation_email
    @user = params[:user]
    @question = params[:question]
    mail(
      subject: '新規質問',
      to: @user.email,
      from: "from@example.com"
      )
  end
end
