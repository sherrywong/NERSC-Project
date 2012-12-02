class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    @url = "http://nersc.herokuapp.com"
    mail(:to => user.email, :subject => "Confirmation Email")
  end
end
