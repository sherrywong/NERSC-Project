class RemoveCreatorFromRisks < ActiveRecord::Migration
  def up
    remove_column :risks, :creator_id
  end

  def down
    add_column :risks, :creator_id, :integer
  end
end
