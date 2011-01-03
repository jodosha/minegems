class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :ensure_site_name

  private
    def ensure_site_name
      @site_name = Site.search(request.subdomain).try(:name)
    end
end
