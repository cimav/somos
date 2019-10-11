class PostLink < ActiveRecord::Base
  attr_accessible :post_id, :link, :description, :image
  belongs_to :post
end
