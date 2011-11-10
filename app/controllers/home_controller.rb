class HomeController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def index
    @post = Post.new
    @post_types = PostType.all
  end
end
