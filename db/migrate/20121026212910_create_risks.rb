class CreateRisks < ActiveRecord::Migration
  def change
    create_table :risks do |t|
      t.belongs_to :project
      t.belongs_to :creator
      t.belongs_to :owner
      t.string :title
      t.text :description
      t.string :probability
      t.float :cost

      t.timestamps
    end
  end
end
