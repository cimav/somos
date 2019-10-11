class PostGroup < ActiveRecord::Base
  attr_accessible :post_id, :group_id

  belongs_to :post
  belongs_to :group
end
