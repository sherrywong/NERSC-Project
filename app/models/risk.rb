class Risk < ActiveRecord::Base
  attr_accessible :cost, :description, :probability, :title, :project_id, :owner_id #, creator_id
   validates_presence_of :cost, :description, :probability, :title, :project_id, :owner_id
   
   #not included:   :project_id, :creator_id, :owner_id
   #three limited values for a probability and cost
   validates_inclusion_of :probability, :in => %w(3 2 1)
   validates_inclusion_of :cost, :in => %w(3 2 1)
   validates_uniqueness_of :title, :scope => :project_id
   validates_inclusion_of :status, :in=>["active", "retired", "pending"]
   validates :project, :presence => true
   #validate :creator_exists
   #validate :owner_exists

   belongs_to :project
   #belongs_to :creator, :class_name => "User"   
   belongs_to :owner, :class_name => "User"
   
=begin clients no longer require a creator.
    def creator_exists
        errors[:creator] << "Creator does not exist" unless User.find_by_id(self.creator_id)
    end


    def owner_exists
        errors[:owner] << "Owner does not exist" unless User.find_by_id(self.owner_id)
    end
=end

end
