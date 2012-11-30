#Controllers should never have to directly access this class.
#Stick with Project/Users, which use methods listed here to
#interact with each other.

class ProjectMembership < ActiveRecord::Base
  attr_accessible :user_id, :project_id
  validates :user, :presence => true
#  validates :project, :presence => true

  validates_uniqueness_of :user_id, :scope => :project_id
  validates_uniqueness_of :project_id, :scope => :user_id
  #restrict one owner per project - custom validator.
  validate :unique_owner_per_project
  validate :user_is_active
  validates_inclusion_of :permission, :in => ["read", "write"]
  #use with add_permissions migration if desired?

  belongs_to :user
  belongs_to :project

  def self.owner_membership_of_project(project)
    find_by_project_id_and_owner(project.id, true)
  end

  def self.owner_of_project(project)
    owner_membership_of_project(project).user
  end

  def self.set_owner_of_project(project, new_owner)
    if (former = owner_membership_of_project(project))
        former.owner = false
        former.permission = "read"
        former.save
    end
    new_ownership = ProjectMembership.find_or_create_by_user_id_and_project_id(:user_id=>new_owner.id, :project_id=>project.id)
    new_ownership.owner = true
    new_ownership.permission = "write"
    new_ownership.save
  end

  #will be needed for adding members to project.
  def unique_owner_per_project
    if owner? and ProjectMembership.exists?(:project_id=>project_id, :owner => true)
        errors.add(:project_id, "#{Project.find_by_id(project_id)} already has an owner")
    end
  end
  def user_is_active
	if not User.find_by_id(user_id).active?
		errors.add(:user_id, "#{User.find_by_id(user_id)} is not an active user")
	end
  end
end
