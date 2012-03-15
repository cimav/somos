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
    @group = Group.where(:short_name => params[:short_name]).first || not_found
    @user = User.find(session[:user].id)
    @members = Membership.where(:group_id => @group.id)
    render :layout => false
  end

  def search 
    @groups = Group.where("name LIKE :n", {:n => "%#{params[:q]}%"}).order("name")
    respond_with do |format|
      format.html do
        if request.xhr?
          render :json => @groups
        end
      end
      format.json do
        render :json => @groups
      end
    end
  end

end
