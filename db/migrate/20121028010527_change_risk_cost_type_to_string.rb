class ChangeRiskCostTypeToString < ActiveRecord::Migration
  def up
    change_table :risks do |t|
      t.change :cost, :string
    end
  end

  def down
    change_table :risks do |t|
      t.change :cost, :float
    end
  end
end
