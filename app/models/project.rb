class Project < ActiveRecord::Base
  attr_accessible :description, :name, :prefix, :probability_impact_11, :probability_impact_12, :probability_impact_13, :probability_impact_21, :probability_impact_22, :probability_impact_23, :probability_impact_31, :probability_impact_32, :probability_impact_33, :owner_id
  #not included: status should not be assignable by the normal user.
  validates_presence_of :name
  validates_uniqueness_of :prefix
  validates_inclusion_of :status, :in=>["active", "retired", "pending"]
  #by row to simplify reading.
  validates_inclusion_of :probability_impact_11, :probability_impact_12, :probability_impact_13, :in => [1,2,3]
  validates_inclusion_of :probability_impact_21, :probability_impact_22, :probability_impact_23, :in => [1,2,3]
  validates_inclusion_of :probability_impact_31, :probability_impact_32, :probability_impact_33, :in => [1,2,3]
  
  before_validation :init_prefix
  def init_prefix
    self.prefix ||= self.name
  end
  
  has_many :project_memberships, :dependent => :destroy #assume destroy for now.
  has_many :users, :through => :project_memberships #identical to members
  has_many :members, :through => :project_memberships, :source => :user   #identical to users, this is preferred.
  has_many :risks

  #Will merge current list with input list, assuming read-only access
  def add_members(members_id_list) #can also just provide the users themselves.
    members_id_list.each do |member_id|
        member = User.find_by_id(member_id)
        ProjectMembership.create(:user_id => member_id, :project_id => self.id)
        self.members << member unless self.members.include? member
    end
    self.save
  end


  def remove_member(member_id)
    @pm = ProjectMembership.find_by_project_id_and_user_id(self.id, member_id)
    if @pm
        @pm.destroy
        self.save
    end
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

  def owner_username #mostly for view.
    if owner.nil?
        return "Owner could not be found - Please contact the database administrator for details."
    else
        owner.username
    end
  end

end
