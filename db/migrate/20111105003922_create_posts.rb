class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user
      t.references :group
      t.string     "entry_type", :null => false
      t.text       "content",    :null => false
      t.integer    "status",     :null => false, :default => 1
      t.timestamps
    end
    add_index("posts", "user_id")
    add_index("posts", "group_id")
  end
end
