class PostEventsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json
  def upcoming
    @events = PostEvent.where("start_date > :date", {:date => Time.now.strftime("%Y-%m-%d")}).limit(10).order(:start_date)
    render :layout => false
  end
end
