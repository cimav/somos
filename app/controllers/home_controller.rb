class HomeController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def index
    @user = User.find(session[:user].id)
    if request.xhr?
      render :layout => false
    end
  end
end
