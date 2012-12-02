class Risk < ActiveRecord::Base
  #to maintain a history log
  audited
   attr_accessible :title, :short_title, :description, :root_cause, :mitigation, :contingency, :cost, :schedule, :technical, :other_type, :probability, :status, :early_impact, :last_impact, :type, :critical_path, :wbs_spec, :comment, :owner_id, :project_id, :creator_id, :edited_by

   validates_inclusion_of :probability, :cost, :schedule, :technical, :in => [3, 2, 1]
   validates_inclusion_of :other_type,  :in => [3, 2, 1], :allow_nil=> true
   validates_presence_of :title, :description, :probability, :cost, :schedule, :technical, :status, :early_impact, :last_impact, :days_to_impact, :owner_id, :project_id, :creator_id
   validates_inclusion_of :status, :in=>["active", "retired", "pending"]

   belongs_to :project
   belongs_to :creator, :class_name => "User"
   belongs_to :owner, :class_name => "User"

  def prefix_id
    return "#{self.project.prefix}-#{self.id}"
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

    def calculate_days_to_impact
      return [self.early_impact - Date.today, 0].max
    end

    def self.create_risk(uid, pid, risk_hash)
      #because user specify owner by username but our db stores a owner id
      if risk_hash[:owner_id] != nil
        @owner = User.find_by_username(risk_hash[:owner_id])
        if @owner!=nil
          if @owner.retired?
            risk_hash[:owner_id] = -2 # invalid id number, corresponds to deactivated user
          elsif !@owner.member?(pid)
            risk_hash[:owner_id] = -1 # invalid id number, corresponds to non-member
          else
            risk_hash[:owner_id] = @owner.id
          end
        else
          risk_hash[:owner_id] = 0 # invalid id number, corresponds to inexisting user
        end
      end
      @risk = Risk.new(risk_hash)
      if @risk.owner_id == 0
        @risk.errors.add(:owner, "is not found in database.")
      elsif @risk.owner_id == -1
        @risk.errors.add(:owner, "has to be a member of this project.")
      elsif @risk.owner_id == -2
        @risk.errors.add(:owner, "cannot be a deactivated user.")
      end
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
      @errors=nil
      if risk_hash[:owner_id]!=nil
        @owner = User.find_by_username(risk_hash[:owner_id])
        if @owner==nil
          @errors= "is not found in database."
          risk_hash[:owner_id] = risk.owner_id
        elsif @owner.retired?
          @errors = "cannot be a deactivated user."
          risk_hash[:owner_id] = risk.owner_id
        elsif !@owner.member?(risk.project_id)
          @errors = "has to be a member of this project."
          risk_hash[:owner_id] = risk.owner_id
        else
          risk_hash[:owner_id] = @owner.id
        end
      end
      @risk.update_attributes(risk_hash)
      @risk.risk_rating = @risk.calculate_risk_rating
      @risk.days_to_impact = @risk.calculate_days_to_impact
      @risk.save
      if @errors!=nil
        @risk.errors.add(:owner, "#{@errors}")
      end
      return @risk
    end
end
