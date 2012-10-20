class Project < ActiveRecord::Base
  attr_accessible :description, :name
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :project_memberships
  has_many :users, :through => :project_memberships
  
  #Will merge current list with input list.
  def add_members(members_list)
    members_list.each do |member|
        #ProjectMembership.create(:user_id => member.id, :project_id => self.id, :owner=>false)
        self.users << member
    end
    self.save
  end
    
end
