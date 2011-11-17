# encoding: utf-8

class PostPhotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "#{Rails.root}/private/post_photos/#{model.id}"
  end


  # Process files as they are uploaded:
  #process :scale => [1024, 768]

  # Create different versions of your uploaded files:
  #version :large do
  #  process :scale => [640, 480]
  #end

  version :medium do
    process :resize_to_fit => [400, 300]
  end

  version :small do
    process :resize_to_fit => [240, 180]
  end

  version :thumbnail do
    process :resize_to_fit => [80, 60]
  end

  version :square do
    process :resize_to_fill => [60, 60]
  end


  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
