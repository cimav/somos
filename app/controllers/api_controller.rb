class ApiController < ApplicationController
  respond_to :json, :html
  def auth
    json = {}
    if u = User.where(:username => params[:username], :token => params[:token]).first
      if u.applications.where(:name => params[:app]).first
        json[:full_name] = u.full_name
      else
        json[:error] = 'Unauthorized'
      end
    else
      json[:error] = 'User not found'
    end
    #render :json => json
    render :inline => "true"
  end
end
