class HomeController < ApplicationController
  def index
    @post_types = PostType.all
    @user_groups = Group.all
  end
end
