class PostsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def show
    @post = Post.find(params[:id])
    render :layout => false
  end

  def recent
    @posts = Post.order("created_at DESC").where("status = 1")
    if !params[:id].blank?
      @posts = @posts.where("id > :id", {:id => params[:id]})
      # TODO: Validate :exclude list, reset if already shown.
      if !params[:exclude].blank?
        @posts = @posts.where("id NOT IN (#{params[:exclude]})")
      end
    else
      @posts = @posts.limit(HOME_INITIAL_POSTS)
    end
    render :layout => false
  end

  def recent_counter
    if !params[:id].blank?
      count = Post.count(:conditions => ["status = 1 AND id > ?", params[:id]])
    else
      count = Post.count(:conditions => ["status = 1"])
    end
    render :text => count
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      flash[:notice] = t :post_created

      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:id] = @post.id
            json[:flash] = flash
            render :json => json
          else
            redirect_to @post
          end
        end
      end
    else
      flash[:error] = t :cant_create_post
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @post.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @post
          end
        end
      end
    end

  end
end
