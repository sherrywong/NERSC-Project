class AddPrefixToProjects < ActiveRecord::Migration
  def up
    add_column :projects, :prefix, :string
    Project.find_all_by_prefix(nil).each do |proj|
        proj.prefix = proj.name
        proj.save
    end
  end
  
  def down
    remove_column :projects, :prefix
  end
end
