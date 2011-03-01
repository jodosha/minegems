class GemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_site
  before_filter :ensure_site_access
  before_filter :load_site

  # GET https://bootstrapp.minege.ms/gems
  def index
    @rubygems = @site.rubygems.latest
  end

  # GET https://bootstrapp.minege.ms/gems/planisphere
  def show
    @rubygem = @site.rubygems.by_name(params[:id]).first
    raise ActiveRecord::RecordNotFound unless @rubygem
  end

  # GET https://bootstrapp.minege.ms/gems/new
  def new
    @rubygem = Rubygem.new
  end

  # POST https://bootstrapp.minege.ms/gems
  def create
    @rubygem = Rubygem.create_version(params[:gem][:file], @site)

    if @rubygem.valid?
      redirect_to gems_path, :notice => "Gem was successful registered"
    else
      flash[:alert] = "There was errors preventing this gem being registered"
      render :new
    end
  end
end
