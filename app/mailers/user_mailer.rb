class UserMailer < ActionMailer::Base
  default from: "sherrywong@berkeley.edu"

  def welcome_email(user)
    @user = user
    @url = "http://nersc.herokuapp.com"
    mail(:to => user.email, :subject => "NERSC Risk Tracker Confirmation Email")
  end

  def risk_notify(risk_owner, risk)
    @risk_owner = risk_owner
    @risk = risk
    @url = risk_index_path(@risk.id)
    mail(:to => risk_owner.email, :subject => "Notification for #{risk.title}'s Early Impact")
  end
end
