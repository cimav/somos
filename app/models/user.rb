class User < ActiveRecord::Base

  has_many :posts
  has_many :comments
  has_many :badges

  has_many :memberships
  has_many :user_badges
  has_many :groups, :through => :memberships
  has_many :badges, :through => :user_badges

  belongs_to :reports_to_user, :class_name => "User", :foreign_key => "reports_to"

  STATUS_ACTIVE   = 1
  STATUS_INACTIVE = 2

  mount_uploader :image, UserImageUploader

  def full_name
    "#{first_name} #{last_name}" rescue 'Error in name'
  end

end
