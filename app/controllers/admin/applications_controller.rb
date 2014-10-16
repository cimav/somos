class Admin::ApplicationsController < ApplicationController
  before_filter :admin_required
  def index  
    @applications = Application.find(:all, :order => "name")
    render :layout => 'admin'
  end

  def show
    redirect_to url_for :controller => 'applications', :action => 'edit', :id=>params['id']
  end

  def new
    @application = Application.new
    render :layout => 'admin'
  end

  def create
    @application = Application.new
    if @application.update_attributes(params[:application]) 
      flash[:info] = "Grupo creado"
      url = url_for :controller => 'applications', :action => 'edit', :id=>@application.id
    else
      flash[:error] = "No se pudo crear"
      url = url_for :controller => 'applications', :action => 'index'
    end
    redirect_to url
  end

  def edit
    @application = Application.find(params[:id])
    render :layout => 'admin'
  end

  def update
    @application=Application.find(params[:id])
    if @application.update_attributes(params[:application]) 
      flash[:info] = "Guardado"
    else
      flash[:error] = "No se pudo guardar"
    end
    redirect_to url_for :controller => 'applications', :action => 'edit', :id=>params['id']
  end
end
