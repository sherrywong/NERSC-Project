class AddStatusToRisks < ActiveRecord::Migration
  def change
    add_column :risks, :status, :string, :default => "active"
  end
end
