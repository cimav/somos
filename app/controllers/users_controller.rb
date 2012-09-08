class UsersController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def profile
    @u = User.where(:username => params[:username]).first
    @posts = @u.posts.order("created_at DESC").where("status = #{Post::ACTIVE}")
    @posts = @posts.where("( 
                           (limited = '0') OR 
                           (user_id = :user_id) OR
                           (id IN (
                                    SELECT post_id FROM post_groups 
                                    WHERE group_id IN (SELECT group_id FROM memberships 
                                                        WHERE user_id = :user_id)
                                  )) )", {:user_id => current_user.id})
    @comment = Comment.new
    render :layout => false
  end

  def upcoming_birthdays
    @users = User.where("CONCAT(YEAR(NOW()), '-', SUBSTR(birth_date, 6, 2), '-', SUBSTR(birth_date,9,2)) >= CURDATE()").order("SUBSTR(birth_date,6,2), SUBSTR(birth_date, 9,2)").limit(5) 
    render :layout => false
  end
 
  def menu
    render :layout => false
  end

  def image
    user = User.find(params[:id])
    send_file user.image_url(params[:size]).to_s, :x_sendfile=>true, :disposition => 'inline' 
  end

  def update
    @user = User.find(params[:id])
    puts params
    if @user.update_attributes(params[:user])
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:id] = @user.id
            json[:username] = @user.username
            render :json => json
          else
            render :inline => "TODO UPDATE RENDER"
          end
        end
      end
    else
      flash[:error] = t :cant_update_user
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @user.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @user
          end
        end
      end
    end
  end

  def user_updated
    render :inline => "TODO"
  end


end
