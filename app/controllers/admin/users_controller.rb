class Admin::UsersController < ApplicationController
  before_filter :admin_required
  def index  
    @users = User.find(:all, :order => "username")
    render :layout => 'admin'
  end

  def show
    redirect_to url_for :controller => 'users', :action => 'edit', :id=>params['id']
  end

  def new
    @user = User.new
    render :layout => 'admin'
  end

  def create
    @user = User.new
    if @user.update_attributes(params[:user]) 
      flash[:info] = "Usuario creado"
      url = url_for :controller => 'users', :action => 'edit', :id=>@user.id
    else
      flash[:error] = "No se pudo crear"
      url = url_for :controller => 'users', :action => 'index'
    end
    redirect_to url
  end

  def edit
    @user = User.find(params[:id])
    render :layout => 'admin'
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(params[:user]) 
      flash[:info] = "Guardado"
    else
      flash[:error] = "No se pudo guardar"
    end
    redirect_to url_for :controller => 'users', :action => 'edit', :id=>params['id']
  end

  def image
    user = User.find(params[:id])
    send_file user.image_url(params[:size]).to_s, :x_sendfile=>true, :disposition => 'inline' 
  end

end
