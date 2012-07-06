class PostEventsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json
  def upcoming
    @events = PostEvent.includes(:post).where("posts.status = :status AND ((start_date >= :date) OR (end_date >= :date))", {:status => Post::ACTIVE,  :date => Time.now.strftime("%Y-%m-%d")}).limit(10).order(:start_date)
    if @events.count > 0
      render :layout => false
    else
      render :inline => ''
    end
  end
end
