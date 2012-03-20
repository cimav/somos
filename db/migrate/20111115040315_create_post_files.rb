class CreatePostFiles < ActiveRecord::Migration
  def change
    create_table :post_files do |t|
      t.references :post
      t.string     :file
      t.timestamps
    end
    add_index(:post_files, :post_id)
  end
end
