class RiskLog < ActiveRecord::Base
    attr_accessible :username, :description, :field, :updated_on, :user_id, :risk_id
    validates_presence_of :username, :description, :field, :updated_on, :user_id, :risk_id
    
    validates_inclusion_of :field, :in=> %w(short_title title description root_cause mitigation contingency probability cost schedule technical other_risk status early_impact last_impact days_to_impact type critical_path wbs_spec)
    belongs_to :user
    belongs_to :risk


    
end
