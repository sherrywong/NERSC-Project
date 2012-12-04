class RemoveFieldsFromRisk < ActiveRecord::Migration
  def up
    remove_column :risks, :short_title
    remove_column :risks, :other_type
  end

  def down
    add_column :risks, :short_title, :string
    add_column :risks, :other_type, :string
  end
end
