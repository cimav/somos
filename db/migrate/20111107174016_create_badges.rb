class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string "name"
      t.string "message"
      t.string "earn_script"
      t.string  "image"
      t.integer "status",       :default => 1
      t.timestamps
    end
  end
end
