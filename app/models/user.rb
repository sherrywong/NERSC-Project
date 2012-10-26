class User < ActiveRecord::Base
  validates_presence_of :email, :first, :last, :password, :username
  validates_inclusion_of :admin, :in => [true, false]
  validates_uniqueness_of :username
  attr_accessible :admin, :email, :first, :last, :password, :username

#Rails internal password digesting (temporary until LDAP)
  has_secure_password

  #These allow you to say @user.project_memberships and @user.projects to get the related teams/projects.
  has_many :project_memberships, :dependent => :destroy
  has_many :projects, :through => :project_memberships

  def admin?
    return self.admin
  end

  def self.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end
    
  #optional: maybe the controller should do the admin check 
  #to present a flash erorr if needed.

  def self.add_new_user(uid, user_hash)
    User.find_by_id(uid).add_new_user(user_hash)
  end
  def add_new_user(user_hash) #returns true if the new user is created.
    return (self.admin? and User.new(user_hash).save)
  end

  #includes default owner
  def create_project(project_hash)
    proj = Project.new(project_hash)
    if self.admin? and proj.save
        pm = ProjectMembership.new(:user_id=>self.id, :project_id => proj.id, :owner=>true)
        proj.owner = self.id
        if not pm.save
            proj.destroy
            return false
        end
    end
    return false
  end
end
