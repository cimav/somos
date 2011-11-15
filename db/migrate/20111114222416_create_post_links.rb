class CreatePostLinks < ActiveRecord::Migration
  def change
    create_table :post_links do |t|
      t.references :post
      t.string :link 
      t.timestamps
    end
    add_index("post_links", "post_id")
  end
end
