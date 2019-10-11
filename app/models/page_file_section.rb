class PageFileSection < ActiveRecord::Base
  attr_accessible :title, :body, :page_id, :position, :status
  belongs_to :page
  has_many :page_file
  after_create :set_position

  PUBLISHED = 1
  DELETED   = 2

  def set_position
    pos = PageFileSection.where(:page_id => self.page_id).maximum('position')
    if pos.nil?
      pos = 1
    else
      pos += 1
    end
    self.position = pos
    self.save
  end
end
