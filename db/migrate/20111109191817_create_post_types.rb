class CreatePostTypes < ActiveRecord::Migration
  def change
    create_table :post_types do |t|
      t.string  :name,        :null => false
      t.integer :category,    :default => 0
      t.integer :status,      :default => 1
      t.timestamps
    end
    add_index(:post_types, :name)
  end
end
