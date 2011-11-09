class GroupsController < ApplicationController
  respond_to :html, :xml, :json

  def list
    @groups = GroupType.where(:can_publish => 1).order('position')
    render :layout => false
  end

  def show
    @group = Group.find(params[:id])
    render :layout => false
  end

end
