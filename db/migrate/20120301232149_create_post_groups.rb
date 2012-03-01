class CreatePostGroups < ActiveRecord::Migration
  def change
    create_table :post_groups do |t|
      t.references :post
      t.references :group
      t.timestamps
    end
    add_index(:post_groups, :post_id)
    add_index(:post_groups, :group_id)
  end
end
