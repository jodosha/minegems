require "spec_helper"

describe AccountsController do
  describe "routing" do

    describe "#show" do
      it "recognizes route" do
        get("http://username.test.host/account").
            should route_to("accounts#show")
      end

      it "requires subdomain" do
        get("/account").
            should_not be_routable
      end
    end

    describe "#update" do
      it "recognizes route" do
        put("http://username.test.host/account").
            should route_to("accounts#update")
      end

      it "requires subdomain" do
        put("/account").
            should_not be_routable
      end
    end

  end
end
