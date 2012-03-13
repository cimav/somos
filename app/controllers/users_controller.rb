class UsersController < ApplicationController
  before_filter :auth_required

  def profile
    @u = User.where(:username => params[:username]).first
    @comment = Comment.new
    render :layout => false
  end

  def upcoming_birthdays
    @users = User.where("CONCAT(YEAR(NOW()), '-', SUBSTR(birth_date, 6, 2), '-', SUBSTR(birth_date,9,2)) >= CURDATE()").order("SUBSTR(birth_date,6,2), SUBSTR(birth_date, 9,2)").limit(5) 
    render :layout => false
  end
 
  def sidebar
    @u = User.where(:username => params[:username]).first
    render :layout => false
  end
end
