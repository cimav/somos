class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  ACTIVE = 1
  DELETED = 2
end
