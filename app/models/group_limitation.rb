class GroupLimitation < ActiveRecord::Base
  belongs_to :group
  belongs_to :by_group, :class_name => "Group", :foreign_key => "group_id"
end
