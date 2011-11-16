class PostFilesController < ApplicationController

  def file
    post = Post.find(params[:id])
    post_file = post.post_file.find(params[:file_id]).file
    send_file post_file.to_s, :x_sendfile=>true
  end

end
