class EditorController < ApplicationController
  def link_dialog
    @page_title = '{#somoslink_dlg.title}'
    render :layout => 'dialog'
  end

  def pages_combo
    page = Page.find(params[:id]) 
    @pages = page.group.pages
    render :layout => false
  end

  def page_files
    page = Page.find(params[:id]) 
    render :layout => false
  end

end
