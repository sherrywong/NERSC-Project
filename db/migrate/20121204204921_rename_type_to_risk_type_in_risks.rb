class RenameTypeToRiskTypeInRisks < ActiveRecord::Migration
  def change
	rename_column :risks, :type, :risk_type
  end
end
