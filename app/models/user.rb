class User < ActiveRecord::Base
  validates_presence_of :email, :first, :last, :username
  validates_presence_of :password, :unless => :password_digest? #unless a password already exists.
  #not included: admin (optional, default = false), status (default active)
  validates_inclusion_of :status, :in=>["active", "retired", "pending"]
  #validates_inclusion_of :admin, :in => [true, false]
  #don't think I need this - db will error out since admin not a boolean.
  validates_uniqueness_of :username
  attr_accessible :admin, :email, :first, :last, :password, :username, :status, :permission

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


  def create_user(user_hash) #returns user object
    @usr = User.new(user_hash)
    @usr.save
    return @usr
  end


  #Do not pass in owner just yet!
  #Current setup: create_project (owner is by default the creator).
  #If another person should be owner, use Proj.owner =
  #(Future change expected)

  def extract_owner_username(project_hash)
    if new_owner = User.find_by_username(project_hash.delete("owner_username"))
        #print "FOUND AN OWNER: #{new_owner}\n"
        #print "NEW HASH: #{project_hash}\n"
    end
    return new_owner
  end

  def create_project(project_hash)
    new_owner = extract_owner_username(project_hash)
    @proj = Project.new(project_hash)
    if self.admin? and @proj.save
        #@proj.add_member(self.id) don't need this line- all admins have access to all projects
        #@proj.edit_member_permission(self, "write")
        @proj.owner = new_owner || self
        #@pm = ProjectMembership.new(:user_id=>self.id, :project_id => @proj.id)
        #@pm.permission = "write"
        #@pm.owner = true
      #if project_hash[project][members].nil?
        #@pm = ProjectMembership.new(:user_id=>self.id, :project_id => @proj.id, :owner=>true, :permission=>"write")
      #else
        #@pm = project_hash[project][members]
        #proj.owner = self.id skipped in case pm errors.
        #if not @pm.save
            #@proj.errors[:membership_errors] = @pm.errors
            #@proj.destroy
            #return false
        #end
      #end
    end
    return @proj #check @proj.errors
  end

  def update_project(project, project_hash)
    new_owner = extract_owner_username(project_hash)
    project.update_attributes(project_hash)
    project.owner = new_owner unless new_owner.nil?
  end

  ##updating risks by SW##
  def update_risk(risk_hash, risk)
    new_owner = extract_owner_username(risk_hash)
    risk.update_attributes(risk_hash)
    risk.owner_id = new_owner.id unless new_owner.nil?
    return risk
  end

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
      @usr.save
      return true
    end
    return false
  end

end
