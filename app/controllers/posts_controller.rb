class PostsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def recent
    @posts = Post.order("created_at DESC")
    render :layout => false
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      flash[:notice] = t :post_created

      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
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
