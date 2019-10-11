class PageGroup < ActiveRecord::Base
  attr_accessible :page_id, :group_id 
  
  belongs_to :page
  belongs_to :group
end
