require 'spec_helper'

describe GemsController do
  describe "GET 'new'" do
    before :each do
      get 'new'
    end

    it "should be successful" do
      response.should be_success
    end

    describe "assigns" do
      it "should include @rubygem" do
        assigns(:rubygem).should_not be_nil
      end
    end
  end

  describe "POST 'create'" do
    context "given a valid gem" do
      before :each do
        post 'create', :gem => rubygem
      end
      let(:rubygem) { rubygem_params }

      it "should redirect to gem index page" do
        response.should redirect_to(gems_path)
      end

      it "should set flash notice" do
        flash[:notice].should == "Gem was successful registered"
      end
    end

    context "given an invalid gem" do
      before :each do
        post 'create', :gem => rubygem
      end
      let(:rubygem) { rubygem_params(:file => nil) }

      it "should render 'new' form" do
        response.should render_template('new')
      end

      it "should set flash error" do
        flash[:error].should == "There was errors preventing this gem being registered"
      end
    end

    describe "assigns" do
      before :each do
        post 'create', :gem => rubygem
      end
      let(:rubygem) { rubygem_params }

      it "should include @rubygem" do
        assigns(:rubygem).should_not be_nil
      end
    end
  end
end
