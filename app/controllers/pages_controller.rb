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
    @group = Group.where(:short_name => params[:group_short_name]).first || not_found
    @page = @group.pages.where(:short_name => params[:page_short_name], :status => Page::PUBLISHED).first || not_found 
    render :layout => false
  end

  def add_page
    if !params[:group_id].blank?
      membership = current_user.memberships.where(:group_id => params[:group_id]).first
      can_publish = membership.can_publish == 1 rescue false
      can_admin = membership.can_admin == 1 rescue false
      can_modify_others = membership.can_admin == 1 rescue false

      if !current_user_is_admin
        if membership.blank?
          raise "User #{current_user.username} doesn't belongs to group #{params[:group_id]}"
        end

        if !can_publish
          raise "User #{current_user.username} doesn't have sufficient permissions to do this action"
        end
      end 

    end
    page = Page.new
    page.title = t :untitled
    page.short_name = (t :untitled).parameterize
    page.group_id = params[:group_id]
    page.user_id = current_user.id
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
            json[:group_id] = @page.group_id
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

  def add_file_section
    @fs = PageFileSection.new
    @fs.page_id = params[:id]
    @fs.status = PageFileSection::PUBLISHED
    @fs.title = t :untitled
    if @fs.save 
      flash[:notice] = t :page_file_section_created
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:id] = @fs.id
            json[:page_id] = @fs.page.id
            json[:flash] = flash
            render :json => json
          else
            redirect_to @fs.page
          end
        end
      end
    else
      flash[:error] = t :cant_create_page_file_section
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @fs.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @fs.page
          end
        end
      end
    end
  end

  def files_section
    @page = Page.find(params[:id])
    render :layout => false
  end

  def edit_section
    @page = Page.find(params[:id])
    @pfs = @page.page_file_section.find(params[:section_id])
    render :layout => false
  end

  def mark_as_deleted
    @page = Page.find(params[:id])

    membership = current_user.memberships.where(:group_id => @page.group.id).first
    can_publish = membership.can_publish == 1 rescue false
    can_admin = membership.can_admin == 1 rescue false
    can_modify_others = membership.can_admin == 1 rescue false

    if !(current_user_is_admin || can_admin || can_modify_others)
      if current_user.id != @page.user_id
        raise "The current user is not the page owner"
      end
    end

    @page.status = Page::DELETED
    if @page.save
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:group_id] = @page.group_id
            render :json => json
          end
        end
      end
    end
  end

  def mark_as_default
    page = Page.find(params[:id])

    membership = current_user.memberships.where(:group_id => page.group.id).first
    can_publish = membership.can_publish == 1 rescue false
    can_admin = membership.can_admin == 1 rescue false
    can_modify_others = membership.can_admin == 1 rescue false

    if !(current_user_is_admin || can_admin || can_modify_others)
      if current_user.id != @page.user_id
        raise "The current user is not the page owner"
      end
    end

    group = Group.find(page.group.id)
    group.default_page = page.id

    if group.save
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:default_msg] = t(:default_page)
            render :json => json
          end
        end
      end
    end


    
  end

end
