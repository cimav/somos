class PostsController < ApplicationController
  before_filter :auth_required, :set_global_vars
  respond_to :html, :json

  def share_form
    @post = Post.new
    @post_types = PostType.where(:category => PostType::USER_POST)
    render :layout => false
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
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
    @comment = Comment.new
    render :layout => false
  end

  def recent_counter
    txt = 0
    count = recent_query(params[:group_id], params[:id]).count
    txt = (t :new_posts_message, :count => count) if count > 0
    render :text => txt
  end

  def create
    # XXX: Ugly hack for multiple file uploads, needs to do more generic fix
    if params[:post][:post_file_attributes].respond_to?('each')
      aux = []
      params[:post][:post_file_attributes]['file'].each do |f|
        aux << {:file => f}
      end
      params[:post][:post_file_attributes] = aux
    end
    # XXX: Ugly hack for multiple photo uploads, needs to do more generic fix
    if params[:post][:post_photo_attributes].respond_to?('each')
      aux = []
      params[:post][:post_photo_attributes]['photo'].each do |f|
        aux << {:photo => f}
      end
      params[:post][:post_photo_attributes] = aux
    end

    # User ID
    params[:post][:user_id] = current_user.id

    @post = Post.new(params[:post])

    

    if @post.save
      flash[:notice] = t :post_created

      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:id] = @post.id
            json[:flash] = flash
            # Save groups to
            params[:to_groups].split(',').each do |g|
              pg = PostGroup.new
              pg.post_id = @post.id
              pg.group_id = g
              pg.save
            end
            render :json => json
          else
            @post_type = PostType.find(@post.post_type_id)
            template = "create_#{@post_type.short_name}"
            render template, :layout => false
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

  def ui
    @post_type = PostType.find(params[:id])

    method = "build_post_#{@post_type.name}"
    template = "ui_#{@post_type.name}"

    @post = Post.new
    if @post.respond_to?(method)
      @post.send(method)
    end
    render template, :layout => false
  end 

  def comments
    @post = Post.find(params[:id])
    @last = params[:last]
    render :layout => false
  end

end
