class SessionsController < ApplicationController
  def authenticate
    auth_hash = request.env['omniauth.auth']

    session[:user_email] = auth_hash['user_info']['email']

    if authenticated?
      redirect_to '/'
    else
      render :text => '401 Unauthorized', :status => 401
    end
  end
end
