require 'spec_helper'

describe AccountsController do

  context "when not logged in" do
    should_require_login :show
    should_require_login :update, :method => :put
  end

  context "when logged in" do
    before(:each) do
      @_user, @_subdomain = login_and_subdomain
    end

    describe "GET show" do
      let(:process!) { get :show }

      it "responds with 200" do
        process!
        response.status.should == 200
        should render_template(:show)
      end

      it "assigns :user" do
        process!
        assigns(:user).should == @_user
      end
    end

    describe "PUT update" do
      context "with valid params" do
        before(:each) do
          put :update, user: { password: "Changed", password_confirmation: "Changed" }
        end

        it "redirects to the dashboard page" do
          should redirect_to(dashboard_url)
        end

        it "updates user" do
          assigns(:user).should == @_user
          assigns(:user).changes.should be_empty
        end
      end

      context "with invalid params" do
        before(:each) do
          put :update, user: { name: "John Doe", password: "Changed", password_confirmation: "Different" }
        end

        it "responds with 200" do
          response.status.should == 200
          should render_template(:show)
        end

        it "does not update user" do
          assigns(:user).should == @_user
          assigns(:user).changes.should_not be_empty
        end
      end
    end
  end

end
