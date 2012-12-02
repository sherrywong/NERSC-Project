require 'spec_helper'

describe "add_fields_to_risks/show" do
  before(:each) do
    @add_fields_to_risk = assign(:add_fields_to_risk, stub_model(AddFieldsToRisk,
      :columna => "",
      :columnB => "",
      :columnc => "Columnc"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Columnc/)
  end
end
