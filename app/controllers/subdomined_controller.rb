class SubdominedController < ApplicationController
  abstract!

  before_filter :authenticate_user!
  before_filter :require_subdomain
  before_filter :authorize_subdomain


  private

  def current_subdomain
    return @current_subdomain if defined?(@current_subdomain)
    @current_subdomain = request.subdomain && Subdomain.find_by_tld(request.subdomain)
  end

  def require_subdomain
    unless current_subdomain
      redirect_to root_url, alert: "Invalid site."
    end
  end

  def authorize_subdomain
    unless current_subdomain.users.where(id: current_user.id).exists?
      head(403)
    end
  end

  def load_site
    @site = current_subdomain
  end

end