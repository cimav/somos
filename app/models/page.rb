class Page < ActiveRecord::Base
  attr_accessible :user_id, :group_id, :title, :short_name, :position, :content, :page_id

  belongs_to :user
  belongs_to :group
  has_many :page_file_section

  after_create :check_short_name
  after_update :check_short_name

  before_update :create_version

  PUBLISHED = 1
  DRAFT     = 2
  VERSION   = 3
  DELETED   = 4

  def check_short_name
    if self.status == Page::PUBLISHED && Page.where(:status => Page::PUBLISHED,:group_id => self.group_id, :short_name => self.short_name).count > 1
      self.short_name = "#{self.short_name}-#{self.id}"
      self.save
    end
  end

  def create_version
    aux = Page.find(self.id)
    page_new = aux.dup
    page_new.status = Page::VERSION
    page_new.page_id = self.id
    page_new.save
  end

end
