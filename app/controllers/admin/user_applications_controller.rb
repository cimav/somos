class Admin::UserApplicationsController < ApplicationController
  before_filter :admin_required

  def create
    js_flash = {}
    @user_application = UserApplication.new
    if @user_application.update_attributes(params[:user_application]) 
      js_flash[:info] = "Agregado"
    else
      js_flash[:error] = "No se pudo agregar"
    end
    respond_to do |format|
      format.json { render json: {id: @user_application.id, flash: js_flash}}
    end
  end

  def update
    js_flash = {}
    @user_application = UserApplication.find(params[:id])
    if @user_application.update_attributes(params[:user_application]) 
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
    @user_application = UserApplication.find(params[:id])
    if @user_application.destroy()
      js_flash[:info] = "Eliminado"
    else
      js_flash[:error] = "No se pudo eliminar"
    end

    respond_to do |format|
      format.json { render json: {flash: js_flash}}
    end
  
  end
end
