class CreateSidebarItemGroups < ActiveRecord::Migration
  def change
    create_table :sidebar_item_groups do |t|
      t.references :sidebar_item
      t.references :group
      t.timestamps
    end
    add_index(:sidebar_item_groups, :sidebar_item_id)
    add_index(:sidebar_item_groups, :group_id)
  end
end
