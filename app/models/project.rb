class Project < ActiveRecord::Base
  attr_accessible :description, :name
  #not included: status
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_inclusion_of :status, :in=>["active", "retired", "pending"]
  
  has_many :project_memberships, :dependent => :destroy #assume destroy for now.
  has_many :users, :through => :project_memberships #identical to members
  has_many :members, :through => :project_memberships, :source => :user   #identical to users, this is preferred.
  has_many :risks
  
  #Will merge current list with input list.
  def add_members(members_id_list) #can also just provide the users themselves.
    members_id_list.each do |member_id|
        member = User.find_by_id(member_id)
        ProjectMembership.create(:user_id => member_id, :project_id => self.id, :owner=>false)
        self.members << member unless self.members.include? member
    end
    self.save
  end
  
  def add_member(member_id)
    ProjectMembership.new(:user_id => member_id, :project_id => self.id, :owner=>false)
    self.members << User.find_by_id(member_id) unless self.members.include? member
    self.save
  end
  
  def remove_member(member_id)
    @pm = ProjectMembership.find_by_project_id_and_user_id(self.id, member_id)
    if @pm
        @pm.destroy
        self.save
    end
  end
  
  def remove_members(members_id_list)
    members_id_list.each do |member_id|
        member = User.find_by_id(member_id)
        pm = ProjectMembership.find_by_user_id_and_project_id(self.id, member_id)
        pm.destroy unless pm.nil or pm.owner
    end
    self.save
  end
  def has_member?(member_id)
    return self.members.include? User.find_by_id(member_id)
  end
  
  def owner
    ProjectMembership.owner_of_project(self)
  end
  
  def owner= (new_owner)
    ProjectMembership.set_owner_of_project(self, new_owner)
  end

  
end
