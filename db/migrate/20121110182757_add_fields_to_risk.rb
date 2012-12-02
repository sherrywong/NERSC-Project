class AddFieldsToRisk < ActiveRecord::Migration
  def change
    add_column :risks, :short_title, :string
    add_column :risks, :create_date, :datetime
    add_column :risks, :root_cause, :text
    add_column :risks, :mitigation, :text
    add_column :risks, :contingency, :text
    add_column :risks, :probability, :integer
    add_column :risks, :cost, :integer
    add_column :risks, :schedule, :integer
    add_column :risks, :technical, :integer
    add_column :risks, :other_type, :integer
    add_column :risks, :risk_rating, :integer
    add_column :risks, :early_impact, :date
    add_column :risks, :last_impact, :date
    add_column :risks, :days_to_impact, :integer
    add_column :risks, :type, :string
    add_column :risks, :critical_path, :string
    add_column :risks, :wbs_spec, :string
    add_column :risks, :comment, :text
    add_column :risks, :edited_by, :string
  end
end
