class GroupsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def list
    @groups = GroupType.where(:can_publish => 1).order('position')
    render :layout => false
  end

  def show
    @group = Group.find(params[:id])
    render :layout => false
  end

end
