class Application < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :user_applications
  has_many :users, :through => :user_applications

  APP_LOCAL = 1
  APP_EXTERNAL = 2
  APP_LINK = 3

  APP_TYPE = { 
    APP_LOCAL => 'Local',
    APP_EXTERNAL => 'Externa/Legacy',
    APP_LINK => 'Enlace'
  }

  def app_type_text
    APP_TYPE[app_type]
  end

end
