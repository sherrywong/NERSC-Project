class RemoveProbabilityFromRisk < ActiveRecord::Migration
  def up
    remove_column :risks, :probability
  end

  def down
    add_column :risks, :probability, :string
  end
end
