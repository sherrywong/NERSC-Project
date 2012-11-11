class RemoveCostFromRisk < ActiveRecord::Migration
  def up
    remove_column :risks, :cost
  end

  def down
    add_column :risks, :cost, :float
  end
end
