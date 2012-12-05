# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
NerscProject::Application.initialize!

NerscProject::Application.config.action_mailer.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
      :address  => "calmail.berkeley.edu",
      :port  => 587,
      :user_name  => "sherrywong@berkeley.edu",
      :password  => "$$$MakesTheWorldGoRound069",
      :authentication => :login
}

NerscProject::Application.config.action_mailer.raise_delivery_errors = true


