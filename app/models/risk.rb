class Risk < ActiveRecord::Base
  attr_accessible :cost, :description, :probability, :title, :project_id, :creator_id, :owner_id
   validates_presence_of :cost, :description, :probability, :title
   
    #not included:   :project_id, :creator_id, :owner_id
   #three limited values for a probability and cost
   validates_inclusion_of :probability, :in => %w(High Medium Low)
   validates_inclusion_of :cost, :in => %w(High Medium Low)
   validates_uniqueness_of :title, :scope => :project_id
   validates :project, :presence => true
   validate :creator_exists
   validate :owner_exists

   belongs_to :project
   belongs_to :creator, :class_name => "User"   
   belongs_to :owner, :class_name => "User"
   
   
    def creator_exists
        errors[:creator] << "Creator does not exist" unless User.find_by_id(self.creator_id)
    end
    def owner_exists
        errors[:owner] << "Owner does not exist" unless User.find_by_id(self.owner_id)
    end
end