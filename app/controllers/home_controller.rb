class HomeController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def index
    if request.xhr?
      render :layout => false
    end
  end

  def loggedout 
    render :layout => false
  end 

end
