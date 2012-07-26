class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :post_type

  has_many :comments
  has_many :post_group

  has_one :post_link
  accepts_nested_attributes_for :post_link

  has_many :post_file
  accepts_nested_attributes_for :post_file

  has_many :post_photo
  accepts_nested_attributes_for :post_photo

  has_one :post_event
  accepts_nested_attributes_for :post_event

  has_one :user_badge

  has_many :likes, :as => :attachable
  accepts_nested_attributes_for :likes

  ACTIVE = 1
  DELETED = 2

end
