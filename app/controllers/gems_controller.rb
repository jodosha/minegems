class GemsController < SubdominedController

  before_filter :load_site


  def index
    @rubygems = @site.rubygems.order("created_at DESC")
  end

  def new
    @rubygem = @site.rubygems.build
  end

  def create
    @rubygem = Rubygem.create_version(params[:gem][:file], @site)

    if @rubygem.valid?
      redirect_to gems_url, notice: "Gem was successful registered"
    else
      flash.now[:alert] = "There was errors preventing this gem being registered"
      render :new
    end
  end

  def show
    @rubygem = @site.rubygems.find_by_name!(params[:id])
  end

end
