class ApplicationController < ActionController::Base
  #protect_from_forgery with: :null_session

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def authenticated?
    if session[:user_auth].blank? 
      user = User.where(:email => session[:user_email], :status => User::STATUS_ACTIVE).first
      session[:user_auth] = user && user.email == session[:user_email]
      if session[:user_auth]
        session[:user_id] = user.id
      end
    else
      session[:user_auth]
    end
  end
  helper_method :authenticated?

  def auth_required
    redirect_to '/login' unless authenticated?
  end

  def admin_required
    raise ActionController::RoutingError.new('Not Found') unless current_user_is_admin

  end

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user_is_admin
  
  def current_user_is_admin
    u = User.find(session[:user_id]) if session[:user_id]   
    @current_user_is_admin ||= u.memberships.includes(:group).where('groups.short_name' => 'admin').references(:group).first.can_admin == 1 rescue false
  end

  helper_method :user_image

  def user_image(id, size)
    url_for(:action => 'image', :controller => 'users', :id => id, :size => size)
  end

end
