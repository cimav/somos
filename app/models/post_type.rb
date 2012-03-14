class PostType < ActiveRecord::Base
  has_many :posts
  USER_POST = 0
  SYSTEM_POST = 1
end
