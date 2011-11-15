class PostFile < ActiveRecord::Base

  belongs_to :post

  mount_uploader :file, PostFileUploader

  before_destroy :delete_linked_file

  def delete_linked_file
    self.remove_file!
  end

end
