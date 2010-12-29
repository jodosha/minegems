class SubdomainsController < ApplicationController
  before_filter :ensure_authenticated_user!

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

  private
    def ensure_authenticated_user!
      params[:controller] = 'devise/sessions' # HACK
      resource = warden.authenticate!(:scope => :user)
      sign_in(:user, resource)
    end
end
