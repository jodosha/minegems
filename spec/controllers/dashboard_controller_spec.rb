require 'spec_helper'

describe DashboardController do

  context "when not logged in" do
    should_require_login :index
  end

  context "when logged in" do
    before(:each) do
      login_and_subdomain
    end

    describe "GET index" do
      before(:each) do
        get :index
      end

      it "responds with 200" do
        response.status.should == 200
        should render_template(:index)
      end
    end
  end

end
