class User < ActiveRecord::Base

  has_many :posts
  has_many :comments

  has_many :memberships
  has_many :groups, :through => :memberships

  STATUS_ACTIVE   = 1
  STATUS_INACTIVE = 2

  mount_uploader :image, UserImageUploader

  def full_name
    "#{first_name} #{last_name}" rescue 'Error in name'
  end

end
