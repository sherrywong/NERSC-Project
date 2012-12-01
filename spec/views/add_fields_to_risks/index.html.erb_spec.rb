require 'spec_helper'

describe "add_fields_to_risks/index" do
  before(:each) do
    assign(:add_fields_to_risks, [
      stub_model(AddFieldsToRisk,
        :columna => "",
        :columnB => "",
        :columnc => "Columnc"
      ),
      stub_model(AddFieldsToRisk,
        :columna => "",
        :columnB => "",
        :columnc => "Columnc"
      )
    ])
  end

  it "renders a list of add_fields_to_risks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Columnc".to_s, :count => 2
  end
end
