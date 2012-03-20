class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :post_type

  has_many :comments

  has_one :post_link
  accepts_nested_attributes_for :post_link

  has_many :post_file
  accepts_nested_attributes_for :post_file

  has_many :post_photo
  accepts_nested_attributes_for :post_photo

  has_one :post_event
  accepts_nested_attributes_for :post_event


end
