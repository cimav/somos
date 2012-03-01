class CreatePageGroups < ActiveRecord::Migration
  def change
    create_table :page_groups do |t|
      t.references :page
      t.references :group
      t.timestamps
    end
    add_index("page_groups", "page_id")
    add_index("page_groups", "group_id")
  end
end
