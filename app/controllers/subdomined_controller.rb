class SubdominedController < ApplicationController
  abstract!

  before_filter :authenticate_user!
  before_filter :require_subdomain
  before_filter :authorize_subdomain

  rescue_from ActiveRecord::RecordNotFound, with: :render_404


  protected

  def render_404(exception = nil)
    exception and logger.info("Rendering 404 with exception: #{exception.message}")

    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404", layout: false, status: :not_found }
      format.any  { head :not_found }
    end
  end

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