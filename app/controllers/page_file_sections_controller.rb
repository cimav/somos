class PageFileSectionsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def update
    @pfs = PageFileSection.find(params[:id])
    if @pfs.update_attributes(params[:page_file_section])
      flash[:notice] = t :page_section_updated
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:id] = @pfs.id
            json[:page_id] = @pfs.page_id
            json[:flash] = flash
            render :json => json
          else
            redirect_to @pfs
          end
        end
      end
    else
      flash[:error] = t :cant_update_page_section
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @page.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @pfs
          end
        end
      end
    end
  end

end
