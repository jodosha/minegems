class RegistrationsController < Devise::RegistrationsController
  before_filter :require_no_subdomain
  respond_to :json, :only => [ :search ]

  # POST /users
  def create
    build_resource

    if resource.create_with_subdomain!(params[:subdomain])
      set_flash_message :notice, :signed_up
      sign_in_and_redirect(resource_name, resource)
    else
      resource.valid? # force the validation messages
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end

  # GET /users/search.json?q=jodosha
  def search
    respond_with User.search(params[:q])
  end
end
