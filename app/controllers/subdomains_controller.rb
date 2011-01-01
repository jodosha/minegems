class SubdomainsController < ApplicationController
  before_filter :ensure_authenticated_user!, :only => [ :create ]
  respond_to :json, :only => [ :search ]

  # POST /subdomains
  def create
    @subdomain = current_user.subdomains.build(params[:subdomain])

    if @subdomain.save
      redirect_to root_url, :notice => "You have successfully setup your account."
    else
      sign_out(:user)
      redirect_to new_user_registration_url, :alert => "Account creation failed, please refill the form."
    end
  end

  # GET /subdomains/search.json?q=sushistar
  def search
    respond_with Subdomain.search(params[:q])
  end

  private
    def ensure_authenticated_user!
      params[:controller] = 'devise/sessions' # HACK
      resource = warden.authenticate!(:scope => :user)
      sign_in(:user, resource)
    end
end
