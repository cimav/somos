class PagesController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json
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
    respond_with do |format|
      format.html do
        if request.xhr?
          json = {}
          json[:id] = page.id
          render :json => json
        end
      end
    end
  end

  def update
    @page = Page.find(params[:id])
    params[:page][:short_name] = params[:page][:title].parameterize
    if @page.update_attributes(params[:page])
      flash[:notice] = t :page_updated
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:id] = @page.id
            json[:title] = @page.title
            json[:short_name] = @page.short_name
            json[:flash] = flash
            render :json => json
          else
            redirect_to @page
          end
        end
      end
    else
      flash[:error] = t :cant_update_page
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @page.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @page
          end
        end
      end
    end
  end
end
