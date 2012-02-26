require "spec_helper"

describe GemsController do
  describe "routing" do

    describe "#index" do
      it "recognizes route" do
        get("http://username.test.host/gems").
            should route_to("gems#index")
      end

      it "requires subdomain" do
        get("/gems").
            should_not be_routable
      end
    end

    describe "#new" do
      it "recognizes route" do
        get("http://username.test.host/gems/new").
            should route_to("gems#new")
      end

      it "requires subdomain" do
        get("/gems/new").
            should_not be_routable
      end
    end

    describe "#create" do
      it "recognizes route" do
        post("http://username.test.host/gems").
            should route_to("gems#create")
      end

      it "requires subdomain" do
        post("/gems").
            should_not be_routable
      end
    end

    describe "#show" do
      it "recognizes route" do
        get("http://username.test.host/gems/foogem").
            should route_to("gems#show", id: "foogem")
      end

      it "requires subdomain" do
        get("/gems/foogem").
            should_not be_routable
      end
    end

  end
end
