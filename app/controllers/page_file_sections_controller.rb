class PageFileSectionsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def update
    @pfs = PageFileSection.find(params[:id])
    if @pfs.update_attributes(params[:page_file_section])
      flash[:notice] = t :pfs_section_updated
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:id] = @pfs.id
            json[:pfs_id] = @pfs.id
            json[:page_id] = @pfs.page_id
            json[:flash] = flash
            render :json => json
          else
            redirect_to @pfs
          end
        end
      end
    else
      flash[:error] = t :cant_update_pfs_section
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @pfs.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @pfs
          end
        end
      end
    end
  end

  def mark_as_deleted
    @pfs = PageFileSection.find(params[:id])

    if !current_user_is_admin
      if current_user.id != @pfs.user_id
        raise "The current user is not the pfs owner"
      end
    end

    @pfs.status = PageFileSection::DELETED
    if @pfs.save
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:pfs_id] = @pfs.id
            json[:page_id] = @pfs.page_id
            render :json => json
          end
        end
      end
    end
  end


end
