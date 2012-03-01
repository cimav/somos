class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     "username",   :null => false
      t.string     "first_name", :null => false
      t.string     "last_name",  :null => false
      t.string     "occupation"
      t.string     "email",      :null => false
      t.string     "location"
      t.integer    "reports_to"
      t.text       "bio"
      t.date       "birth_date"
      t.string     "address1"
      t.string     "address2"
      t.string     "city"
      t.references :state
      t.string     "zip",          :limit => 20
      t.references :country
      t.string     "mobile_phone", :limit => 20
      t.string     "home_phone",   :limit => 20
      t.string     "work_phone",   :limit => 20
      t.string     "website"
      t.string     "lat",          :limit => 20
      t.string     "long",         :limit => 20
      t.string     "image"
      t.integer    "status",     :null => false, :default => 1
      t.timestamps
    end
  end
end
