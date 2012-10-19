class ProjectMembership < ActiveRecord::Base
  attr_accessible :owner
  validates :user, :project

  validates_uniqueness_of :user_id, :scope => :project_id
  validates_uniqueness_of :project_id, :scope => :user_id
  #restrict one owner per project.
  validate :owner, :uniqueness=> {:scope => :project_id}, :if => :owner

  has_many :users, :projects


  def owner_of_team(team)
    find_by_team_id_and_owner(team.id, true)
  end
end
