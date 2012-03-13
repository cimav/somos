class UsersController < ApplicationController
  before_filter :auth_required

  def profile
    @u = User.where(:username => params[:username]).first
    @comment = Comment.new
    render :layout => false
  end
 
  def sidebar
    @u = User.where(:username => params[:username]).first
    render :layout => false
  end
end
