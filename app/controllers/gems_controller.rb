class GemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_site
  before_filter :ensure_site_access
  before_filter :load_site

  # GET https://bootstrapp.gemsmineapp.com/gems
  def index
  end

  # GET https://bootstrapp.gemsmineapp.com/gems/new
  def new
    @rubygem = Rubygem.new
  end

  # POST https://bootstrapp.gemsmineapp.com/gems
  def create
    @rubygem = Rubygem.create_version(params[:gem][:file], @site)

    if @rubygem.valid?
      redirect_to gems_path, :notice => "Gem was successful registered"
    else
      flash[:error] = "There was errors preventing this gem being registered"
      render :new
    end
  end
end
