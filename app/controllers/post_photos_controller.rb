class PostPhotosController < ApplicationController
  def photo
    post = Post.find(params[:id])
    post_photo = post.post_photo.find(params[:photo_id]).photo_url(params[:version]).to_s
    send_file post_photo.to_s, :x_sendfile=>true
  end
end
