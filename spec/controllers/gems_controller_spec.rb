require 'spec_helper'

describe GemsController do

  let(:rubygem) {
    FactoryGirl.create(:rubygem, name: "gemmy", subdomain: @_subdomain) do |rubygem|
      FactoryGirl.create(:version, rubygem: rubygem)
    end
  }

  context "when not logged in" do
    should_require_login :index, :new
    should_require_login :create, method: "post"
    should_require_login :show, id: "gemmy"
  end

  context "when logged in" do
    before(:each) do
      @_user, @_subdomain = login_and_subdomain
    end

    describe "GET index" do
      before(:each) do
        get :index
      end

      it "responds with 200" do
        response.status.should == 200
        should render_template("index")
      end
    end

    describe "GET new" do
      before(:each) do
        get :new
      end

      it "responds with 200" do
        response.status.should == 200
        should render_template(:new)
      end

      it "initializes :rubygem" do
        assigns(:rubygem).should be_a(Rubygem)
      end
    end

    describe "POST create" do
      context "given a valid gem" do
        let(:process!) { post :create, gem: { file: rubygem_file('test-0.0.0.gem') } }

        it "creates :rubygem" do
          lambda {
            process!
            assigns(:rubygem).should be_a(Rubygem)
            assigns(:rubygem).should_not be_new_record
          }.should change(Version, :count).by(1)
        end

        it "redirects to the gem index" do
          process!
          should redirect_to(gems_url)
        end

        it "sets flash notice" do
          process!
          flash[:notice].should == "Gem was successful registered"
        end
      end

      context "given an invalid gem" do
        let(:process!) { post :create, gem: {} }

        it "responds with 200" do
          process!
          response.status.should == 200
        end

        it "does not create :rubygem" do
          process!
          assigns(:rubygem).should be_a(Rubygem)
          assigns(:rubygem).should be_new_record
        end

        it "re-renders template 'new'" do
          process!
          should render_template("new")
        end

        it "sets flash alert" do
          process!
          flash.now[:alert].should == "There was errors preventing this gem being registered"
        end
      end

    end

    describe "GET show" do
      let(:process!) { get :show, id: rubygem.name }

      it "responds with 200" do
        process!
        response.status.should == 200
        should render_template("show")
      end

      it "assigns :rubygem" do
        process!
        assigns(:rubygem).should == rubygem
      end

      it "does not load other users' gem with the same name" do
        rubygem = FactoryGirl.create(:rubygem)
        get :show, id: rubygem.name
        response.status.should == 404
      end
    end
  end

end
