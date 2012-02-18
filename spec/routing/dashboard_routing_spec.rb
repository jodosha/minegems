require "spec_helper"

describe DashboardController do
  describe "routing" do

    describe "#index" do
      it "recognizes route" do
        get("http://username.test.host/").
            should route_to("dashboard#index")
      end

      it "requires subdomain" do
        get("/").
            should_not route_to("dashboard#index")
      end
    end

  end
end
