class CommentsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def create

    @comment = Comment.new(params[:comment])

    if @comment.save
      flash[:notice] = t :comment_created

      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:id] = @comment.id
            json[:post_id] = @comment.post_id
            json[:flash] = flash
            render :json => json
          else
            redirect_to @comment.post
          end
        end
      end
    else
      flash[:error] = t :cant_create_comment
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @comment.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @comment.post
          end
        end
      end
    end
  end
end
