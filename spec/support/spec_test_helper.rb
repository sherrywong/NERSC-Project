module SpecTestHelper
  def login_admin
    login(:admin)
  end

  def login(user)
    user = User.where(:login => user.to_s)
    #request.session[:uid] = user.id
  end

  def current_user
    #User.find(request.session[:uid])
  end
end
