class CreateProjectMemberships < ActiveRecord::Migration
  def change
    create_table :project_memberships do |t|
      t.references :user
      t.references :team
      t.boolean :owner, :default => false
      t.timestamps
    end
  end
end
