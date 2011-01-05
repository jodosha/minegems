class SiteController < ApplicationController
  before_filter :authenticate_user!
end