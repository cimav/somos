class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     "username", :null => false
      t.string     "first_name", :null => false
      t.string     "last_name",  :null => false
      t.string     "email",      :null => false
      t.date       "birth_date"
      t.text       "bio"
      t.string     "image"
      t.integer    "reports_to"
      t.integer    "status",     :null => false, :default => 1
      t.timestamps
    end
  end
end
