class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer    "attachable_id"
      t.string     "attachable_type"
      t.references :user
      t.timestamps
    end
    add_index(:likes, :user_id)
  end
end
