class PingController < ApplicationController
  def index
    render :text => 'OK', :layout => false
  end
end
