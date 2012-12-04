class User < ActiveRecord::Base
  validates_presence_of :email, :first, :last, :username
  validates_presence_of :password, :unless => :password_digest? #unless a password already exists.
  #not included: admin (optional, default = false), status (default active)
  validates_inclusion_of :status, :in=>["active", "retired", "pending"]
  #validates_inclusion_of :admin, :in => [true, false]
  #don't think I need this - db will error out since admin not a boolean.
  validates_uniqueness_of :username
  attr_accessible :admin, :email, :first, :last, :password, :username, :status, :permission
  validates :email, :email_format => {:message => "is not a valid e-mail address"}
#Rails internal password digesting (temporary until LDAP)
  has_secure_password

  #These allow you to say @user.project_memberships and @user.projects to get the related teams/projects.
  has_many :project_memberships, :dependent => :destroy
  has_many :projects, :through => :project_memberships
  #has_many :created_risks, :class_name=> "Risk", :foreign_key => :creator_id
  has_many :owned_risks, :class_name => "Risk", :foreign_key => :owner_id

#  def can_edit(proj_id)
#    pm = ProjectMembership.find_by_user_id_and_project_id(self.id, proj_id)
#    return false if pm.nil? or pm.permission == "read"
#    return true #otherwise
#  end

  def admin?
    return self.admin
  end

  def powner?(proj_id)
    return self==Project.find_by_id(proj_id).owner
  end

  def rowner?(risk_id)
    return self==Risk.find_by_id(risk_id).owner
  end

  def active?
    return self.status == "active"
  end

  def inactive?
  return !(active?)
  end

  def retired?
    return self.status == "retired"
  end

  def self.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end

  def member?(pid)
    return ( p = Project.find_by_id(pid) and p.has_member?(self))
  end

  def create_user(user_hash) #returns user object
    @usr = User.new(user_hash)
	@usr.save
    return @usr
  end


  #Note: this method expects "owner_username" because key values from the params hash
  # are passed in as strings, not symbols. Be sure to use the string version when
  # writing rails code as well (eg testing).
  def extract_owner_username(project_hash)
    new_owner = User.find_by_username(project_hash.delete("owner_username"))
    return new_owner
  end

  def create_project(project_hash)
    new_owner = extract_owner_username(project_hash)
    project_hash[:owner_id]=new_owner.id
    @proj = Project.new(project_hash)
    @proj.save
    return @proj #check @proj.errors
  end

  def update_project(project, project_hash)
    @proj = project
    new_owner = extract_owner_username(project_hash)
    @proj.owner = new_owner
    temp= @proj.update_attributes(project_hash)
    if not temp
      @proj.owner = orig_owner
      if pm = ProjectMembership.find_by_user_id_and_project_id(new_owner.id, @proj.id)
         pm.destroy unless new_owner == orig_owner
      end
    end
    return @proj
  end

  #deactivating project/risk/user
  def deactivate_project(project_id)
    @proj = Project.find_by_id(project_id)
    if @proj
      @proj.status = "retired"
      @proj.save
    end
    return @proj
  end

  def deactivate_risk(risk_id)
    @risk = Risk.find_by_id(risk_id)
    if @risk
        @risk.status = "retired"
        @risk.save
    end
    return @risk
  end

  def deactivate_user(user_id)
    @usr = User.find_by_id(user_id)
    if @usr and self.admin? and not @usr.admin?
      @usr.status = "retired"
      return @usr.save
    end
    return false
  end

  #reactivating project/risk/user - identical to deactivation except setting = active.
  def reactivate_project(project_id)
    @proj = Project.find_by_id(project_id)
    if @proj
      @proj.status = "active"
      @proj.save
    end
    return @proj
  end

  def reactivate_risk(risk_id)
    @risk = Risk.find_by_id(risk_id)
    if @risk
        @risk.status = "active"
        @risk.save
    end
    return @risk
  end

  def reactivate_user(user_id)
    @usr = User.find_by_id(user_id)
    if @usr and self.admin? and not @usr.admin?
      @usr.status = "active"
      return @usr.save
    end
    return false
  end


end
