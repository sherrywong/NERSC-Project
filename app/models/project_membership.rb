class ProjectMembership < ActiveRecord::Base
  attr_accessible :owner, :user_id, :project_id
  validates :user, :presence => true
  validates :project, :presence => true

  validates_uniqueness_of :user_id, :scope => :project_id
  validates_uniqueness_of :project_id, :scope => :user_id
  #restrict one owner per project - custom validator.
  validate :unique_owner_per_project

  belongs_to :user
  belongs_to :project


  def owner_of_project(project)
    find_by_project_id_and_owner(project.id, true)
  end
  
  def unique_owner_per_project
    if owner? and ProjectMembership.exists?(:project_id=>project_id, :owner => true)
        errors.add(:project_id, "#{project_id} already has an owner")
    end
  end
end
