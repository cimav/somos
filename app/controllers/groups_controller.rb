class GroupsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def list
    @groups = GroupType.where(:display => GroupType::STREAM).order('position')
    render :layout => false
  end

  def members
    @members = Membership.where(:group_id => params[:id])
    render :layout => false
  end

  def page_list
    @group = Group.find(params[:id])
    @user = User.find(session[:user].id)
    render :layout => false
  end

  def show
    @group = Group.find(params[:id])
    render :layout => false
  end

end
