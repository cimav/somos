class PagesController < ApplicationController
  def list
    @pages = Page.where(:group_id => params[:group_id]).order('position')
    render :layout => false
  end

  def display
    @page = Page.find(params[:id])
    render :layout => false
  end
end
