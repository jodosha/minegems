class AccountsController < SubdominedController

  before_filter :find_user


  def show
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to dashboard_url, notice: "Your account was successfully updated."
    else
      render "show"
    end
  end

  protected

  def find_user
    @user = current_user
  end

end
