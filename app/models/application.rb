class Application < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :user_applications
  has_many :users, :through => :user_applications

  APP_LOCAL = 1
  APP_EXTERNAL = 2

end
