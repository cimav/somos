# coding: utf-8
class PageFilesController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def create
    flash = {}
    @page_id = params[:page_file]['page_id']
    params[:page_file]['file'].each do |f|
      @page_file = PageFile.new
      @page_file.page_file_section_id = params[:page_file]['page_file_section_id']
      @page_file.file = f
      @page_file.title = f.original_filename
      @page_file.status = PageFile::PUBLISHED

      if @page_file.save
        flash[:notice] = "Archivo subido exitosamente."
      else
        flash[:error] = "Error al subir archivo."
      end
    end

    render :layout => false
  end

  def destroy
    @page_file = PageFile.find(params[:id])
    flash = {}
    if @page_file.destroy
      flash[:notice] = "Archivo eliminado"
      # LOG
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            render :json => json
          else
            redirect_to @page_file
          end
        end
      end
    else
      flash[:error] = "Error al eliminar archivo"
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @page_file
          end
        end
      end
    end

  end

  def update
    @page_file = PageFile.find(params[:id])
    flash = {}

    if @page_file.update_attributes(params[:page_file])
      flash[:notice] = "Descripción actualizada."
      # LOG
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:id] = params[:id]
            json[:fs_id] = @page_file.page_file_section_id
            json[:page_id] = @page_file.page_file_section.page_id
            json[:newtitle] = params[:page_file][:title]
            json[:newdesc] = params[:page_file][:description]
            render :json => json
          else
            redirect_to @page_file
          end
        end
      end
    else
      flash[:error] = "Error al actualizar la descripción."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:id] = params[:id]
            json[:fs_id] = @page_file.page_file_section_id
            json[:page_id] = @page_file.page_file_section.page_id
            json[:newtitle] = params[:page_file][:title]
            json[:newdesc] = params[:page_file][:description]
            json[:errors] = @page_file.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @page_file
          end
        end
      end
    end
  end

  def reorder
    pos = 0
    params[:page_file_id].each do |f|
      pos += 1
      pf = PageFile.find(f)
      pf.position = pos
      pf.save
    end
    render :inline => 'OK'
  end

  def file
    s = PageFile.find(params[:id])
    filename = File.basename s.file.to_s
    send_file s.file.to_s, :x_sendfile=>true, :filename => filename
  end 

  def edit_details
    @pf = PageFile.find(params[:id])
    render :layout => false
  end

  def mark_as_deleted
    @f = PageFile.find(params[:id])

    membership = current_user.memberships.where(:group_id => @f.page_file_section.page.group.id).first
    can_publish = membership.can_publish == 1 rescue false
    can_admin = membership.can_admin == 1 rescue false
    can_modify_others = membership.can_admin == 1 rescue false

    if !(current_user_is_admin || can_admin || can_modify_others)
      if current_user.id != @f.user_id
        raise "The current user is not the file owner"
      end
    end

    @f.status = PageFile::DELETED
    if @f.save
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:id] = @f.id
            render :json => json
          end
        end
      end
    end
  end

end
