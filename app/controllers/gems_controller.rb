class GemsController < ApplicationController
  # GET /gems
  def index
  end

  # GET /gems/new
  def new
    @rubygem = Rubygem.new
  end

  # POST /gems
  def create
    @rubygem = Rubygem.new(params[:gem])

    if @rubygem.save
      redirect_to gems_path, :notice => "Gem was successful registered"
    else
      flash[:error] = "There was errors preventing this gem being registered"
      render :new
    end
  end
end
