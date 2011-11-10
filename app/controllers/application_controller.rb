class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticated?
    @user = User.where(:email => session[:user_email], :status => User::STATUS_ACTIVE).first
    @user && @user.email == session[:user_email]
  end
  helper_method :authenticated?

  def auth_required
    redirect_to '/auth/admin' unless authenticated?
  end

end
