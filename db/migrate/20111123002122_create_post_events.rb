class CreatePostEvents < ActiveRecord::Migration
  def change
    create_table :post_events do |t|
      t.references :post
      t.string     :title
      t.datetime   :start_date
      t.datetime   :end_date
      t.text       :location
      t.text       :information
      t.string     :link
      t.string     :image
      t.string     :lat,          :limit => 20
      t.string     :long,         :limit => 20
      t.timestamps
    end
    add_index(:post_events, :post_id)
  end
end
