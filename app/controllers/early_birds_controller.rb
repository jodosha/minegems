class EarlyBirdsController < ApplicationController
  def create
    @early_bird = EarlyBird.new(params[:early_bird])

    @message = if @early_bird.save
      :success
    else
      @early_bird.errors[:email].first
    end

    render :index
  end
end
