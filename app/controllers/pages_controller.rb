class PagesController < ApplicationController
  def list
    @pages = Page.where(:group_id => params[:group_id]).order('position')
    render :layout => false
  end

  def show
    @page = Page.find(params[:id])
    render :layout => false
  end

  def show_group_page
    # TODO: Validate group
    @user = User.find(session[:user].id)
    @page = Page.find(params[:id])
    render :layout => false
  end

  def add_page
    user = User.find(session[:user].id)
    if !params[:group_id].blank?
      membership = user.memberships.where(:group_id => params[:group_id]).first
      if membership.blank?
        raise "User #{user.username} doesn't belongs to group #{params[:group_id]}"
      end
      if membership.can_publish != 1
        raise "User #{user.username} doesn't have sufficient permissions to do this action"
      end

    end
    page = Page.new
    page.title = t :untitled
    page.short_name = (t :untitled).parameterize
    page.group_id = params[:group_id]
    page.user_id = user.id
    page.save
    render :inline => "TODO"
  end

  def update
    @page = Page.find(params[:id])
    params[:page][:short_name] = params[:page][:title].parameterize
    @page.update_attributes(params[:page])
    render :inline => params[:page][:title]
  end

end
