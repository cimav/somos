class PageFile < ActiveRecord::Base

  attr_accessible :page_file_section_id, :file, :title, :description, :position, :status

  belongs_to :page_file_section
  mount_uploader :file, PageFileUploader

  after_create :set_position

  PUBLISHED = 1
  DELETED   = 2

  def set_position
    pos = PageFile.where(:page_file_section_id => self.page_file_section_id).maximum('position')
    if pos.nil?
      pos = 1
    else
      pos += 1
    end
    self.position = pos
    self.save
  end

end
