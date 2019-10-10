class PostEventsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json
  def upcoming
    @events = PostEvent.includes(:post).where("posts.status = :status AND ((start_date >= :date) OR (end_date >= :date))", {:status => Post::ACTIVE,  :date => Time.now.strftime("%Y-%m-%d")}).references(:post).limit(10).order(:start_date)
    if @events.count > 0
      render :layout => false
    else
      render :inline => ''
    end
  end

  def calendar
    @year = params[:year]
    @events = PostEvent.includes(:post).where("posts.status = :status AND ((start_date >= :date1) AND (start_date <= :date2))", {:status => Post::ACTIVE,  :date1 => "#{@year}-1-1", :date2 => "#{@year}-12-31"}).references(:user).order(:start_date)
    render :layout => false
  end
end
