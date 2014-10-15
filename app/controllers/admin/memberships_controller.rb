class Admin::MembershipsController < ApplicationController
  before_filter :admin_required

  def create
    js_flash = {}
    @membership = Membership.new
    @membership.can_publish = 1
    @membership.can_modify_others = 1
    @membership.can_admin = 1
    if @membership.update_attributes(params[:membership]) 
      js_flash[:info] = "Agregado"
    else
      js_flash[:error] = "No se pudo agregar"
    end
    respond_to do |format|
      format.json { render json: {id: @membership.id, flash: js_flash}}
    end
  end

  def update
    js_flash = {}
    @membership = Membership.find(params[:id])
    if @membership.update_attributes(params[:membership]) 
      js_flash[:info] = "Guardado"
    else
      js_flash[:error] = "No se pudo guardar"
    end

    respond_to do |format|
      format.json { render json: {flash: js_flash}}
    end
  
  end

  def destroy
    js_flash = {}
    @membership = Membership.find(params[:id])
    if @membership.destroy()
      js_flash[:info] = "Eliminado"
    else
      js_flash[:error] = "No se pudo eliminar"
    end

    respond_to do |format|
      format.json { render json: {flash: js_flash}}
    end
  
  end

end
