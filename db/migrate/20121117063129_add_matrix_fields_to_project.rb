class AddMatrixFieldsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :probability_impact_11, :integer, :default => 1
    add_column :projects, :probability_impact_12, :integer, :default => 1
    add_column :projects, :probability_impact_13, :integer, :default => 1
    add_column :projects, :probability_impact_21, :integer, :default => 1
    add_column :projects, :probability_impact_22, :integer, :default => 1
    add_column :projects, :probability_impact_23, :integer, :default => 1
    add_column :projects, :probability_impact_31, :integer, :default => 1
    add_column :projects, :probability_impact_32, :integer, :default => 1
    add_column :projects, :probability_impact_33, :integer, :default => 1
  end
end
