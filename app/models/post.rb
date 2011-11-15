class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :post_type

  has_one :post_link
  accepts_nested_attributes_for :post_link

  has_one :post_file
  accepts_nested_attributes_for :post_file

end
