class CreateRiskLogs < ActiveRecord::Migration
  def change
    create_table :risk_logs do |t|
      t.references :user
      t.references :risk
      t.text :description
      t.string :field
      t.string :username
      t.datetime :updated_on
      t.timestamps
    end
  end
end
