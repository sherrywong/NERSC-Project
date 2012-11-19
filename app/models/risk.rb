class Risk < ActiveRecord::Base
  #to maintain a history log
  audited
   attr_accessible :title, :short_title, :description, :root_cause, :mitigation, :contingency, :cost, :schedule, :technical, :other_type, :probability, :status, :early_impact, :last_impact, :type, :critical_path, :wbs_spec, :comment, :owner_id, :project_id, :creator_id

   validates_inclusion_of :probability, :cost, :schedule, :technical, :in => [3, 2, 1]
   validates_inclusion_of :other_type,  :in => [3, 2, 1], :allow_nil=> true
   validates_presence_of :title, :description, :probability, :cost, :schedule, :technical, :status, :early_impact, :last_impact, :days_to_impact, :owner_id, :project_id, :creator_id

   validates_inclusion_of :status, :in=>["active", "retired", "pending"]

   belongs_to :project
   belongs_to :creator, :class_name => "User"
   belongs_to :owner, :class_name => "User"

=begin
    def map_to_int(string)
      if string == "High"
        return 3
      elsif string == "Medium"
         return 2
      else
         return 1
       end
    end
=end

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
      proj = self.project
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
          risk_hash[:owner_id] = @owner.id
        else
          risk_hash[:owner_id] = 0 # invalid id number
        end
      end
      @risk = Risk.new(risk_hash)
      if @risk.owner_id == 0
        @risk.errors[:owner] << "does not exist"
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


  ##this is probably not needed anymore? since i'm updating risk in user.rb##
    def self.update_risk(risk_hash, risk)
      if risk_hash[:owner_id]!=nil
   @owner = User.find_by_username(risk_hash[:owner_id])
        if @owner==nil
          risk.errors[:owner] << "does not exist"
        else
          risk_hash[:owner_id] = @owner.id
        end
      end
      if risk.errors.empty?
        risk.update_attributes!(risk_hash)
        risk.risk_rating = risk.calculate_risk_rating
        risk.days_to_impact = risk.calculate_days_to_impact
        risk.save
      end
      return risk
    end
end
