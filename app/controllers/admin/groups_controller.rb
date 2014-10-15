class Admin::GroupsController < ApplicationController
  before_filter :admin_required
  def index  
    @groups = Group.find(:all, :order => "group_type_id, position")
    render :layout => 'admin'
  end

  def show
    redirect_to url_for :controller => 'groups', :action => 'edit', :id=>params['id']
  end

  def new
    @group = Group.new
    render :layout => 'admin'
  end

  def create
    @group = Group.new
    if @group.update_attributes(params[:group]) 
      flash[:info] = "Grupo creado"
      url = url_for :controller => 'groups', :action => 'edit', :id=>@group.id
    else
      flash[:error] = "No se pudo crear"
      url = url_for :controller => 'groups', :action => 'index'
    end
    redirect_to url
  end

  def edit
    @group = Group.find(params[:id])
    render :layout => 'admin'
  end

  def update
    @group=Group.find(params[:id])
    if @group.update_attributes(params[:group]) 
      flash[:info] = "Guardado"
    else
      flash[:error] = "No se pudo guardar"
    end
    redirect_to url_for :controller => 'groups', :action => 'edit', :id=>params['id']
  end
end
