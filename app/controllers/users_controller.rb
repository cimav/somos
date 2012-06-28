class UsersController < ApplicationController
  before_filter :auth_required

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

end
