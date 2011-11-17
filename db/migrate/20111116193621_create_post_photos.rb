class CreatePostPhotos < ActiveRecord::Migration
  def change
    create_table :post_photos do |t|
      t.references :post
      t.string "photo"
      t.string "description"
      t.timestamps
    end
    add_index("post_photos", "post_id")
  end
end
