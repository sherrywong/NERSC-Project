require 'spec_helper'

describe "AddFieldsToRisks" do
  describe "GET /add_fields_to_risks" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get add_fields_to_risks_path
      response.status.should be(200)
    end
  end
end
