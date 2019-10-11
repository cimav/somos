class Comment < ActiveRecord::Base
  attr_accessible :post_id, :user_id, :content, :status
  belongs_to :post
  belongs_to :user

  ACTIVE = 1
  DELETED = 2
end
