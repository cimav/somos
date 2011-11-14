class PostsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def show
    @post = Post.find(params[:id])
    render :layout => false
  end

  def recent_query (group_id, id)
    posts = Post.order("created_at DESC").where("status = 1")

    if !group_id.blank?
      posts = posts.where("group_id = :group_id", {:group_id => group_id})
    end

    if !id.blank?
      posts = posts.where("id > :id", {:id => id})
    else
      posts = posts.limit(HOME_INITIAL_POSTS)
    end
  end

  def recent
    @posts = recent_query(params[:group_id], params[:id])
    render :layout => false
  end

  def recent_counter
    txt = 0
    count = recent_query(params[:group_id], params[:id]).count
    txt = (t :new_posts_message, :count => count) if count > 0
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
