# encoding: utf-8

class PostFileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "#{Rails.root}/private/post_files/#{model.id}"
  end
end
