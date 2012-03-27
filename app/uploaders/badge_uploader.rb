# encoding: utf-8

class BadgeUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "assets/badges/#{model.id}"
  end

  def default_url
     "/assets/" + [version_name, "badge_default.jpg"].compact.join('_')
  end

  # Create different versions of your uploaded files:
  version :full do
    process :resize_to_fill => [300, 300]
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
