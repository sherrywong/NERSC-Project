class AddEditedByToRisk < ActiveRecord::Migration
  def change
    add_column :risks, :edited_by, :string
  end
end
