class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def set_global_vars 
    user = User.find(session[:user].id)
    @current_user_pic = user.image_url(:small).to_s
    @current_user_display_name = user.display_name
  end

  def authenticated?
    if session[:user_auth].blank? 
      @user = User.where(:email => session[:user_email], :status => User::STATUS_ACTIVE).first
      session[:user] = @user
      session[:user_auth] = @user && @user.email == session[:user_email]
      if session[:user_auth]
        session[:user_id] = @user.id
      end
    else
      session[:user_auth]
    end
  end
  helper_method :authenticated?

  def auth_required
    redirect_to '/auth/admin' unless authenticated?
  end

  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
