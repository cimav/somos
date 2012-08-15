class PageGroup < ActiveRecord::Base
  belongs_to :page
  belongs_to :group
end
