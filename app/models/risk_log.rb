class RiskLog < ActiveRecord::Base
    attr_accessible :username, :description, :field, :updated_on, :user_id, :risk_id
    validates_presence_of :username, :description, :field, :updated_on, :user_id, :risk_id
    
    validates_inclusion_of :field, :in=> %w(short_title title description owner root_cause mitigation contingency probability cost schedule technical other_type status early_impact last_impact type critical_path wbs_spec comment)
    belongs_to :user
    belongs_to :risk


    def can_delete?(field)
      return field==comment
    end

    
end
