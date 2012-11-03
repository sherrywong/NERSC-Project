class User < ActiveRecord::Base
  validates_presence_of :email, :first, :last, :password, :username
  #not included: admin (optional, default = false), status (default active)
  validates_inclusion_of :status, :in=>["active", "retired", "pending"]
  #validates_inclusion_of :admin, :in => [true, false]
  #don't think I need this - db will error out since admin not a boolean.
  validates_uniqueness_of :username
  attr_accessible :admin, :email, :first, :last, :password, :username, :status

#Rails internal password digesting (temporary until LDAP)
  has_secure_password

  #These allow you to say @user.project_memberships and @user.projects to get the related teams/projects.
  has_many :project_memberships, :dependent => :destroy
  has_many :projects, :through => :project_memberships
  #has_many :created_risks, :class_name=> "Risk", :foreign_key => :creator_id
  has_many :owned_risks, :class_name => "Risk", :foreign_key => :owner_id

  def admin?
    return self.admin
  end

  def owner?(proj_id)
    return self==Project.find_by_id(proj_id).owner
  end

  def active?
    return self.status == "active"
  end

  def retired?
    return self.status == "retired"
  end
  
  def self.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end

  def add_new_user(user_hash) #returns user object
    @usr = User.new(user_hash)
    if self.admin? 
        if user_hash[:admin]
            @usr.admin = true
        end
        @usr.save
    else
        @usr.errors[:current] << "Current user does not have permission to create new users (must be admin)"
    end
    return @usr
  end

  #Do not pass in owner just yet!
  #Current setup: create_project (owner is by default the creator).
  #If another person should be owner, use Proj.owner = 
  #(Future change expected)
  def create_project(project_hash)
    @proj = Project.new(project_hash)
    if self.admin? and @proj.save
        @pm = ProjectMembership.new(:user_id=>self.id, :project_id => @proj.id, :owner=>true)
        #proj.owner = self.id skipped in case pm errors.
        if not @pm.save
            @proj.errors[:membership_errors] = @pm.errors
            @proj.destroy
            #return false
        end
    end
    if not self.admin?
        @proj.errors[:current] << "Current user does not have permission to create projects (must be admin)"
    end
    return @proj #check @proj.errors
  end
  
  def create_risk_for_project(project_id, risk_hash)
    #risk_hash[:creator_id] = self.id
    risk_hash[:owner_id] = self.id #default owner = creator
    risk_hash[:project_id] = project_id
    @proj = Project.find_by_id(project_id)
    @rsk = Risk.new(risk_hash)
    if @proj and self.projects.include? @proj#not nil
        @rsk.save
    end
    if not @proj
        @rsk.errors[:project] << "Given project does not exist"
    end
    if not self.projects.include? @proj
        @rsk.errors[:current] << "Current user is not a member of this project"
    end
    return @rsk
  end
  
  def deactivate_project(project_id)
    @proj = Project.find_by_id(project_id)
    if @proj and (self.admin? or @proj.owner == self)
        @proj.status = "retired"
        @proj.save
    end
    if not (self.admin? or @proj.owner == self)
        @proj.errors[:current] << "Current user does not have permission to deactive project (must be admin or project owner)"
    end
    return @proj
  end
  
  def deactivate_user(user_id)
    @usr = User.find_by_id(user_id)
    if @usr and self.admin?
        @usr.status = "retired"
        @usr.save
    end
    if not self.admin?
        @usr.errors[:current] << "Current user does not have permission to deactive users (must be admin)"
    end
    return @usr
  end
  
end
