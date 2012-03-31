class EditorController < ApplicationController
  def link_dialog
    @page_title = '{#somoslink_dlg.title}'
    render :layout => 'dialog'
  end
end
