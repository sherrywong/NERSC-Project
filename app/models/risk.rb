class Risk < ActiveRecord::Base
  attr_accessible :cost, :description, :probability, :title, :project_id, :creator_id, :owner_id
   validates_presence_of :cost, :description, :probability, :title, :project_id, :creator_id, :owner_id
   #three limited values for a probability.
   validates_inclusion_of :probability, :in => %w(High Medium Low)
   validates_uniqueness_of :title, :scope => :project_id
  
  belongs_to :project
  belongs_to :creator, :class_name => "User"
  belongs_to :owner, :class_name => "User"
end
