class PageFileSection < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :page
  has_many :page_file
end
