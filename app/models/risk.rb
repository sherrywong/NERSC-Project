class Risk < ActiveRecord::Base
  #to maintain a history log
  has_paper_trail :on => [:update, :destroy]

   attr_accessible :title, :short_title, :description, :root_cause, :mitigation, :contingency, :cost, :schedule, :technical, :other_type, :probability, :status, :early_impact, :last_impact, :type, :critical_path, :wbs_spec, :comment, :owner_id, :project_id, :creator_id

   validates_inclusion_of :probability, :cost, :schedule, :technical, :in => [3, 2, 1]
   validates_inclusion_of :other_type,  :in => [3, 2, 1], :allow_nil=> true
   validates_presence_of :title, :description, :probability, :cost, :schedule, :technical, :status, :early_impact, :last_impact, :days_to_impact, :owner_id, :project_id, :creator_id
   #validates_uniqueness_of :title, :scope => :project_id #no longer required!
    #risks are uniquely identified by proj-prefix + risk_id.

   validates_inclusion_of :status, :in=>["active", "retired", "pending"]

   #validate :creator_exists
   #validate :owner_exists

   belongs_to :project
   belongs_to :creator, :class_name => "User"
   belongs_to :owner, :class_name => "User"

=begin clients no longer require a creator.
    def creator_exists
        errors[:creator] << "Creator does not exist" unless User.find_by_id(self.creator_id)
    end
=end

    def map_to_int(string)
	if string == "High"
	  return 3
       elsif string == "Medium"
         return 2
       else
         return 1
       end
    end

    def find_username(user_id)
	return User.find_by_id(user_id).username
    end

    def owner_exists?(user_id)
        if User.find_by_id(user_id)==nil
          errors[:owner] << "Owner does not exist"
          return false
        end
        return true
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
          risk_hash[:owner_id] = nil
        end
      end
      @risk = Risk.new(risk_hash)
      @risk.creator_id = uid
      @risk.project_id = pid
      @risk.risk_rating = @risk.calculate_risk_rating
      @risk.days_to_impact = @risk.calculate_days_to_impact
      @risk.save
      return @risk
    end

  ##this is probably not needed anymore? since i'm updating risk in user.rb##
    def update_risk(risk_hash, risk)
      if risk_hash[:owner_id] != nil
        if risk.owner_exists?(risk_hash[:owner_id])
          risk_hash[:owner_id] = User.find_by_id(risk_hash[:owner_id])
        else
          risk_hash[:owner_id] = nil # will trigger an error message
        end
      risk.update_attributes!(risk_hash)
      return risk
      end
    end
end
