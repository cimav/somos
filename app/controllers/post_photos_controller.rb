class PostPhotosController < ApplicationController
  def photo
    post = Post.find(params[:id])
    if params[:version] == 'original'
      post_photo = post.post_photo.find(params[:photo_id]).photo_url.to_s
    else
      post_photo = post.post_photo.find(params[:photo_id]).photo_url(params[:version]).to_s
    end
    send_file post_photo.to_s, :x_sendfile=>true, :disposition => 'inline'
  end
end
