class GroupsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def list

    @groups = Group.includes(:group_type).where('group_types.display_in' => GroupType::STREAM)

    @groups = @groups.where("( 
                           (groups.limited = '0') OR 
                           (groups.id IN (
                                    SELECT group_id FROM group_limitations
                                    WHERE by_group_id IN (SELECT group_id FROM memberships 
                                                        WHERE user_id = :user_id)
                                  )) )", {:user_id => current_user.id})

    @groups = @groups.order('group_types.position').order('groups.position')

    @group_types = GroupType.where(:display_in => GroupType::STREAM).order('position')
    
    render :layout => false
  end

  def members
    @members = Membership.where(:group_id => params[:id])
    render :layout => false
  end

  def page_list
    @group = Group.find(params[:id])
    render :layout => false
  end

  def show
    group_q = Group.where(:short_name => params[:short_name])

    @group = group_q.first || not_found

    if @group.limited != '0' 
      group_l = group_q.where("id IN (
                                    SELECT group_id FROM group_limitations
                                    WHERE by_group_id IN (SELECT group_id FROM memberships 
                                                        WHERE user_id = :user_id)
                                    )", {:user_id => current_user.id}) 
      render :layout => 'group_need_permissions'
    else
      render :layout => false
    end
  end

  def search 
    @groups = Group.where("name LIKE :n", {:n => "%#{params[:q]}%"}).order("name")
    respond_with do |format|
      format.html do
        if request.xhr?
          render :json => @groups
        else
          render :inline => 'Only works via ajax'
        end
      end
      format.json do
        render :json => @groups
      end
    end
  end

end
