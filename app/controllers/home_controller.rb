class HomeController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def index
    @sidebar_items = SidebarItem.order(:position)

    @sidebar_items = @sidebar_items.where("(limited = '0') OR 
                                           (id IN (
                                                  SELECT sidebar_item_id FROM sidebar_item_groups 
                                                  WHERE group_id IN (SELECT 
                                                                       group_id 
                                                                     FROM 
                                                                       memberships 
                                                                     WHERE 
                                                                       user_id = :user_id)
                                                   )
                                           ) ", {:user_id => current_user.id})

    if request.xhr?
      render :layout => false
    end
  end

  def loggedout 
    render :layout => false
  end 

end
