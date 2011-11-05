class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :user
      t.references :group
      t.integer    "can_publish", :default => 1
      t.integer    "can_read",    :default => 1
      t.integer    "can_admin",   :default => 1
      t.integer    "status",      :default => 1
      t.timestamps
    end
    add_index("memberships", "user_id")
    add_index("memberships", "group_id")
  end
end
