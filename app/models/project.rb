class Project < ActiveRecord::Base
  attr_accessible :description, :name
  validates_presence_of :name
  validates_uniqueness_of :name
  
  #These allow for @project.teams and @project.users. There's also an alias: @project.members
  has_many :project_memberships
  has_many :users, :through => :project_memberships
  
  def members #alias for users.
    self.users
  end
  
  def add_members(members_list)
    self.members |= members_list
  end
    
end
