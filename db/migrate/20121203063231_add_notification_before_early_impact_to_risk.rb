class AddNotificationBeforeEarlyImpactToRisk < ActiveRecord::Migration
  def change
    add_column :risks, :notification_before_early_impact, :integer
  end
end
