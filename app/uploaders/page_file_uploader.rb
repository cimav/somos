# encoding: utf-8

class PageFileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "#{Rails.root}/private/page_files/#{model.id}"
  end
end
