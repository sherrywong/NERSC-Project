require 'spec_helper'

describe "add_fields_to_risks/edit" do
  before(:each) do
    @add_fields_to_risk = assign(:add_fields_to_risk, stub_model(AddFieldsToRisk,
      :columna => "",
      :columnB => "",
      :columnc => "MyString"
    ))
  end

  it "renders the edit add_fields_to_risk form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => add_fields_to_risks_path(@add_fields_to_risk), :method => "post" do
      assert_select "input#add_fields_to_risk_columna", :name => "add_fields_to_risk[columna]"
      assert_select "input#add_fields_to_risk_columnB", :name => "add_fields_to_risk[columnB]"
      assert_select "input#add_fields_to_risk_columnc", :name => "add_fields_to_risk[columnc]"
    end
  end
end
