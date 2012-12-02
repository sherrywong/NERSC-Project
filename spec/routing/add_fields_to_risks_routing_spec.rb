require "spec_helper"

describe AddFieldsToRisksController do
  describe "routing" do

    it "routes to #index" do
      get("/add_fields_to_risks").should route_to("add_fields_to_risks#index")
    end

    it "routes to #new" do
      get("/add_fields_to_risks/new").should route_to("add_fields_to_risks#new")
    end

    it "routes to #show" do
      get("/add_fields_to_risks/1").should route_to("add_fields_to_risks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/add_fields_to_risks/1/edit").should route_to("add_fields_to_risks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/add_fields_to_risks").should route_to("add_fields_to_risks#create")
    end

    it "routes to #update" do
      put("/add_fields_to_risks/1").should route_to("add_fields_to_risks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/add_fields_to_risks/1").should route_to("add_fields_to_risks#destroy", :id => "1")
    end

  end
end
