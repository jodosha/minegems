class SiteController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_site
  before_filter :ensure_site_access
end