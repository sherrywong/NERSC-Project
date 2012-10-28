class MakeRiskOwnerReferenceUsers < ActiveRecord::Migration
    #no guarantee this works - doesn't show up in schema.
    #that being said, model validations should also handle the foreign key.
  def up
    change_column :risks, :owner_id, :integer, :references => :users
  end

  def down
    change_column :risks, :owner_id, :integer
  end
end
