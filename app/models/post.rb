class Post < ActiveRecord::Base
  attr_accessible :user_id, :group_id, :post_type_id, :content, :limited, :status, :post_photo_attributes, :post_file_attributes, :post_link_attributes, :post_group_attributes, :post_event_attributes

  after_initialize :default_values


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

  private
    def default_values
      self.content ||= " "
    end

end
