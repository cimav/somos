class PostsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def show
    @post = Post.find(params[:id])
    render :layout => false
  end

  def recent
    @posts = Post.order("created_at DESC").where("status = 1")

    if !params[:group_id].blank?
      @posts = @posts.where("group_id = :group_id", {:group_id => params[:group_id]})
    end

    if !params[:id].blank?
      @posts = @posts.where("id > :id", {:id => params[:id]})
    else
      @posts = @posts.limit(HOME_INITIAL_POSTS)
    end

    render :layout => false
  end

  def recent_counter
    # TODO: Fix conditions for groups
    if !params[:id].blank?
      count = Post.count(:conditions => ["status = 1 AND id > ?", params[:id]])
    else
      count = Post.count(:conditions => ["status = 1"])
    end
    if (count > 0)
      txt = (t :new_posts_message, :count => count)
    else
      txt = 0
    end
    render :text => txt
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
