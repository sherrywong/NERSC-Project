class Risk < ActiveRecord::Base
  #to maintain a history log
  has_paper_trail
  attr_accessible :title, :description, :root_cause, :mitigation, :contingency, :cost, :schedule, :technical, :triggers, :probability, :status, :strategy, :early_impact, :last_impact, :risk_type, :critical_path, :wbs_spec, :comment, :owner_id, :project_id, :creator_id, :notification_before_early_impact

   validates_inclusion_of :probability, :cost, :schedule, :technical, :in => [3, 2, 1, 0]
   validates_numericality_of :notification_before_early_impact, :only_integer =>true, :greater_than_or_equal_to =>0, :message => "has to be a non-negative integer.", :allow_nil=>true
   validates_presence_of :title, :probability, :status, :early_impact, :last_impact, :days_to_impact, :owner_id, :project_id, :creator_id
   validates_inclusion_of :status, :in=>["active", "retired", "pending", "rejected"], :message => "has to be one of either 'active', 'retired', 'pending', or 'rejected'."
   validates_inclusion_of :strategy, :in=>["accept", "monitor", "mitigate", "transfer", "avoid", "retire"], :message => "has to be one of either 'accept', 'monitor', 'mitigate', 'transfer', 'avoid', or 'retire'."
   validate :any_present?
   validates_date :early_impact, :last_impact, :on_or_after => lambda {Date.current}, :message => "cannot be before today."
   validate :early_impact_precedes_last_impact

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

  def early_impact_precedes_last_impact
    if self.last_impact - self.early_impact <0
      errors.add("Early impact", "has to precede last impact.")
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
      @added = false
      @owner = User.find_by_username(risk_hash[:owner_id])
      @creator = User.find_by_id(uid)
      risk_hash[:owner_id] = @owner.id
      @risk = Risk.new(risk_hash)
      if !@owner.member?(pid) and (@creator.admin? or @creator.powner?(pid))
        owner_id = [] << @owner.id
        Project.find_by_id(pid).add_members(owner_id)
      elsif !@owner.member?(pid)
        @risk.errors.add("Owner", "has to be a project member.") 
        @added = true
      end
  
      @risk.creator_id = uid
      @risk.project_id = pid
      @risk.risk_rating = @risk.calculate_risk_rating
      if @risk.errors.empty?
        @risk.days_to_impact = @risk.calculate_days_to_impact
        @risk.save
      elsif @added = true
        Project.find_by_id(pid).remove_member(@owner.id)
      end
      return @risk
    end

    def self.update_risk(risk_hash, risk, user)
      @risk = risk
      @owner = User.find_by_username(risk_hash[:owner_id])
      risk_hash[:owner_id] = @owner.id
      if @risk.update_attributes(risk_hash)
        if !@owner.member?(@risk.project_id) and (user.admin? or user.powner?(@risk.project_id))
          owner_id = [] << @owner.id
          Project.find_by_id(@risk.project_id).add_members(owner_id)
        elsif !@owner.member?(@risk.project_id)
          @risk.errors.add("Owner", "has to be a project member.") 
        end
        if @risk.errors.empty?
          @risk.risk_rating = @risk.calculate_risk_rating
          @risk.days_to_impact = @risk.calculate_days_to_impact
          @risk.save
        end
      end
      return @risk
    end
end
