class AddTriggersAndStrategyToRisks < ActiveRecord::Migration
  def change
    add_column :risks, :triggers, :string
    add_column :risks, :strategy, :string
  end
end
