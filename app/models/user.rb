class User < ActiveRecord::Base
  validates_presence_of :admin, :email, :first, :last, :password, :username
  validates_uniqueness_of :username
  attr_accessible :admin, :email, :first, :last, :password, :username
  
#Rails internal password digesting (temporary until LDAP)
  has_secure_password

  #These allow you to say @user.project_memberships and @user.projects to get the related teams/projects.
  has_many :project_memberships #
  has_many :projects, :through => :project_memberships

  def admin?
    return self.admin
  end

  #optional: maybe the controller should do the admin check 
  #to present an error if needed?
  def create_user(user_hash) #returns true if the new user is created.
    return (self.admin? and User.new(user_hash).save)
  end
end
