class CreateGroupTypes < ActiveRecord::Migration
  def change
    create_table :group_types do |t|
      t.string     "name",      :null => false
      t.string     "description"
      t.integer    "position"
      t.integer    "required",  :default => 1
      t.integer    "display",   :default => 1
      t.integer    "status",    :default => 1
      t.timestamps
    end
  end
end
