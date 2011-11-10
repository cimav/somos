class Group < ActiveRecord::Base
  belongs_to :group_type
  has_many :memberships
  has_many :users, :through => :memberships
end
