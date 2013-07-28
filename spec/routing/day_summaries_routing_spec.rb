require "spec_helper"

describe DaySummariesController do
  describe "routing" do

    it "routes to #index" do
      get("/day_summaries").should route_to("day_summaries#index")
    end

    it "routes to #new" do
      get("/day_summaries/new").should route_to("day_summaries#new")
    end

    it "routes to #show" do
      get("/day_summaries/1").should route_to("day_summaries#show", :id => "1")
    end

    it "routes to #edit" do
      get("/day_summaries/1/edit").should route_to("day_summaries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/day_summaries").should route_to("day_summaries#create")
    end

    it "routes to #update" do
      put("/day_summaries/1").should route_to("day_summaries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/day_summaries/1").should route_to("day_summaries#destroy", :id => "1")
    end

  end
end
