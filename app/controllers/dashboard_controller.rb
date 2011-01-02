class DashboardController < ApplicationController
  before_filter :load_and_ensure_site!

  def index
  end

  private
    def load_and_ensure_site!
      @site = Site.find_by_tld(request.subdomain)
    end
end
