class CreatePostTypes < ActiveRecord::Migration
  def change
    create_table :post_types do |t|
      t.string  "name", :null => false
      t.string  "short_name", :null => false
      t.string  "share_title", :null => false
      t.integer "in_stream", :default => 1
      t.integer "in_pages", :default => 0
      t.integer "status", :default => 1
      t.timestamps
    end
  end
end
