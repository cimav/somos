class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :user
      t.references :group
      t.string     "title",      :null => false
      t.string     "short_name", :null => false
      t.integer    "position",   :null => false, :default => 1
      t.string     "can_modify"
      t.string     "can_read",   :default => "*"
      t.integer    "status",     :null => false, :default => 1
      t.timestamps
    end
    add_index("pages", "user_id")
    add_index("pages", "group_id")
  end
end
