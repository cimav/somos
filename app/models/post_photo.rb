class PostPhoto < ActiveRecord::Base

  belongs_to :post

  mount_uploader :photo, PostPhotoUploader

  before_destroy :delete_linked_photo

  def delete_linked_photo
    self.remove_file!
  end

end
