class DashboardController < SiteController
  before_filter :load_site

  def index
    @plan, @collaborators_count = 'free', 1
    @rubygems  = @site.rubygems.latest
    @downloads = 0
  end
end
