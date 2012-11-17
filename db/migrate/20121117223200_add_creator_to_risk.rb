class AddCreatorToRisk < ActiveRecord::Migration
  def change
    add_column :risks, :creator_id, :integer, :references => :users
  end
end
