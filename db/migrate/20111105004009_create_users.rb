class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     "username", :null => false
      t.string     "first_name", :null => false
      t.string     "last_name",  :null => false
      t.string     "occupation"
      t.string     "email",      :null => false
      t.string     "phone1",     :null => false
      t.string     "phone2",     :null => false
      t.string     "location"
      t.date       "birth_date"
      t.text       "bio"
      t.string     "image"
      t.integer    "reports_to"
      t.integer    "status",     :null => false, :default => 1
      t.timestamps
    end
  end
end
