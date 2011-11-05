class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :group_type
      t.string     "name",        :null => false
      t.string     "description"
      t.integer    "position"
      t.integer    "can_publish", :default => 1
      t.string     "can_read",    :default => "*"
      t.integer    "status",      :default => 1
      t.timestamps
    end
    add_index("groups", "group_type_id")
  end
end
