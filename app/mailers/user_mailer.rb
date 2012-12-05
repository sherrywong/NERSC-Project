class UserMailer < ActionMailer::Base
  default from: "sherrywong@berkeley.edu"

  def welcome_email(user)
    @user = user
    @url = "http://nersc.herokuapp.com"
    mail(:to => user.email, :subject => "NERSC Risk Tracker Confirmation Email")
  end
end
