class User < ActiveRecord::Base
  attr_accessible :admin, :email, :first, :last, :password, :username
  has_many :projects
  has_many :risks, :through => :projects
  #needs validations

  def admin?
    return self.admin
  end

  def create_user(user_hash) #returns true if the new user is created.
    return (self.admin? and User.new(user_hash).save)
  end
end
