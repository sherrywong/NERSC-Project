class Risk < ActiveRecord::Base
  attr_accessible :title, :short_title, :description, :root_cause, :mitigation, :contingency, :cost, :schedule, :technical, :other_type, :probability, :status, :early_impact, :last_impact, :type, :critical_path, :wbs_spec, :comment, :owner_id, :project_id
   validates_presence_of :title, :description, :cost, :schedule, :technical, :probability, :status, :risk_rating, :early_impact, :last_impact, :days_to_impact, :type, :project_id, :owner_id

   #not included:   :project_id, :creator_id, :owner_id
   #three limited values for a probability and cost

   validates_inclusion_of :probability, :cost, :schedule, :technical, :other_type, :in => %w(3 2 1)
   validates_uniqueness_of :title, :short_title, :scope => :project_id
   #validates_uniqueness_of :title, :scope => :project_id #no longer required!
    #risks are uniquely identified by proj-prefix + risk_id.

   validates_inclusion_of :status, :in=>["active", "retired", "pending"]

   #validate :creator_exists
   validate :owner_exists

   belongs_to :project
   #belongs_to :creator, :class_name => "User"
   belongs_to :owner, :class_name => "User"

=begin clients no longer require a creator.
    def creator_exists
        errors[:creator] << "Creator does not exist" unless User.find_by_id(self.creator_id)
    end
=end


    def owner_exists(username)
        if User.find_by_username(username)==nil
          errors[:owner] << "Owner does not exist"
          return false
        end
        return true
    end

    def calculate_risk_rating
      return self.probability * [self.cost, self.schedule, self.technical].max
    end


    def calculate_days_to_impact
      return [self.early_impact-Date.today, 0].max
    end

    def self.create_risk(uid, pid, risk_hash)
      @risk = Risk.new(risk_hash)
    #  @risk.creator_id = uid
      @risk.owner_id = uid
      @risk.project_id = pid
      @risk.risk_rating = @risk.calculate_risk_rating
      @risk.days_to_impact = @risk.calculated_days_to_impact
      if !@risk.save?
    return false
      end
      return @risk
    end


end
