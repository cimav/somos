class PageFile < ActiveRecord::Base
  belongs_to :page
  mount_uploader :file, PageFileUploader

  before_destroy :delete_linked_file

  def delete_linked_file
    self.remove_file!
  end
end
