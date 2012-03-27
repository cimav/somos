class Badge < ActiveRecord::Base
  has_many :users, :through => :user_badges
  mount_uploader :image, BadgeUploader
end
