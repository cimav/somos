class GroupType < ActiveRecord::Base
  has_many :group
  
  STREAM  = 1
  PROFILE = 2
  NEVER   = 99

  REQUIRED = 1
  NOT_REQUIRED = 0
end
