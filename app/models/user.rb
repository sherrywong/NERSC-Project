class User < ActiveRecord::Base
  validates_presence_of :email, :first, :last, :password, :username
  #validates_inclusion_of :admin, :in => [true, false]
  #don't think I need this - db will error out since admin not a boolean.
  validates_uniqueness_of :username
  attr_accessible :admin, :email, :first, :last, :password, :username

#Rails internal password digesting (temporary until LDAP)
  has_secure_password

  #These allow you to say @user.project_memberships and @user.projects to get the related teams/projects.
  has_many :project_memberships, :dependent => :destroy
  has_many :projects, :through => :project_memberships
  has_many :created_risks, :class_name=> "Risk", :foreign_key => :creator_id
  has_many :owned_risks, :class_name => "Risk", :foreign_key => :owner_id

  def admin?
    return self.admin
  end

  def self.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end
    
  #optional: maybe the controller should do the admin check 
  #to present a flash error if needed.

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
        #proj.owner = self.id
        if not pm.save
            proj.destroy
            #return false
        end
        #return true
    end
    #return false
    return proj #check proj.Errors for errors?
  end
  
  def create_risk(project_id, risk_hash)
    print "UNDEFINED"
  end
end
