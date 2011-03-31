class SettingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_site
  before_filter :ensure_site_access
  before_filter :load_site

  # GET /settings
  def show
    @deploy_password = ::Devise::Encryptors::Aes256.decrypt(@site.deploy_user.encrypted_password, Devise.pepper)
  end

  # PUT /settings
  def update
    if current_user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Your settings was saved."
    else
      flash[:alert] = "There was some errors preventing your settings to being saved."
      render :show
    end
  end
end
