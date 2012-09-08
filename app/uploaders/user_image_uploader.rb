# encoding: utf-8

class UserImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "#{Rails.root}/private/profile_images/#{model.id}"
  end

  def default_url
     "/assets/" + [version_name, "user_default.jpg"].compact.join('_')
  end

  # Create different versions of your uploaded files:
  version :profile do
    process :resize_to_fill => [200, 200]
  end

  version :medium do
    process :resize_to_fill => [100, 100]
  end

  version :small do
    process :resize_to_fill => [48, 48]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
