class Risk < ActiveRecord::Base
  #to maintain a history log
  has_paper_trail
  attr_accessible :title, :description, :root_cause, :mitigation, :contingency, :cost, :schedule, :technical, :triggers, :probability, :status, :strategy, :early_impact, :last_impact, :type, :critical_path, :wbs_spec, :comment, :owner_id, :project_id, :creator_id, :notification_before_early_impact

   validates_inclusion_of :probability, :cost, :schedule, :technical, :in => [3, 2, 1, 0]
   validates_numericality_of :notification_before_early_impact, :only_integer =>true, :greater_than_or_equal_to =>0, :message => "has to be a non-negative integer.", :allow_nil=>true
   validates_presence_of :title, :description, :probability, :status, :early_impact, :last_impact, :days_to_impact, :owner_id, :project_id, :creator_id
   validates_inclusion_of :status, :in=>["active", "retired", "pending", "reject"], :message => "has to be one of either 'active', 'retired', 'pending', or 'reject'."
   validates_inclusion_of :strategy, :in=>["accept", "monitor", "mitigate", "transfer", "avoid", "retired"], :message => "has to be one of either 'accept', 'monitor', 'mitigate', 'transfer', 'avoid', or 'retired'."
   validate :any_present?


   belongs_to :project
   belongs_to :creator, :class_name => "User"
   belongs_to :owner, :class_name => "User"

  def prefix_id
    return "#{self.project.prefix}-#{self.id}"
  end

  def any_present?
    if %w(cost schedule technical).all?{|attr| self[attr]==0}
      errors.add_to_base("At least one of 'cost', 'schedule', or 'technical' have to be filled in.")
    end
  end
    def find_username(user_id)
      return User.find_by_id(user_id).username
    end

    def owner_exists?(username)
      if User.find_by_username(username)==nil
        return false
      else
        return true
      end
    end

    def calculate_risk_rating
      proj = self.project || Project.find_by_id(project_id)
      return eval(%Q{proj.probability_impact_#{self.probability}#{[self.cost, self.schedule, self.technical].max}})
    end
	
	def matrix_coordinate
		return "probability_impact_#{self.probability}#{[self.cost, self.schedule, self.technical].max}"
	end

    def calculate_days_to_impact
      return [self.early_impact - Date.today, 0].max
    end

    def self.create_risk(uid, pid, risk_hash)
      #because user specify owner by username but our db stores a owner id
      @owner = User.find_by_username(risk_hash[:owner_id])
      risk_hash[:owner_id] = @owner.id
      @risk = Risk.new(risk_hash)
      @risk.creator_id = uid
      @risk.project_id = pid
      @risk.risk_rating = @risk.calculate_risk_rating
      @risk.days_to_impact = @risk.calculate_days_to_impact
      if @risk.errors.empty?
        @risk.save
      end
      return @risk
    end

    def self.update_risk(risk_hash, risk, user)
      @risk = risk
      @owner = User.find_by_username(risk_hash[:owner_id])
      risk_hash[:owner_id] = @owner.id
      @risk.update_attributes(risk_hash)
      @risk.risk_rating = @risk.calculate_risk_rating
      @risk.days_to_impact = @risk.calculate_days_to_impact
      @risk.save
      return @risk
    end
end
