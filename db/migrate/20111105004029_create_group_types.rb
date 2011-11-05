class CreateGroupTypes < ActiveRecord::Migration
  def change
    create_table :group_types do |t|
      t.string     "name",        :null => false
      t.string     "description"
      t.integer    "position"
      t.integer    "obligatory",  :default => 1
      t.integer    "can_publish", :default => 1
      t.string     "can_read",    :default => "*"
      t.integer    "status",      :default => 1
      t.timestamps
    end
  end
end
