class AddPermissionsToProjectMembership < ActiveRecord::Migration
  def change
    add_column :project_memberships, :permission, :string, :default => "read"
  end
end
