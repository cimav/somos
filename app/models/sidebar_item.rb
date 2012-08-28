class SidebarItem < ActiveRecord::Base
  # attr_accessible :title, :body

  INTERNAL = 1
  EXTERNAL = 2
  TEXT = 3
  GET = 4
end
