class SessionsController < ApplicationController

  def create
    session[:user_email] = auth_hash['info']['email']

    if authenticated?
      redirect_to '/'
    else
      render :text => '401 Unauthorized', :status => 401
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_email] = nil
    session[:user_auth] = nil
    redirect_to root_url
  end

  def failure
    render :text => '403 Auth method has failed', :status => 403
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end

end
