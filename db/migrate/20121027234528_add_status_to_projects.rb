class AddStatusToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :status, :string, :default => "active"
  end
end
