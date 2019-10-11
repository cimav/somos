class PostEvent < ActiveRecord::Base
  attr_accessible :post_id, :title, :start_date, :end_date, :location ,:information, :link, :image, :lat, :long
  belongs_to :post
end
