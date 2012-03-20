class CreateUserBadges < ActiveRecord::Migration
  def change
    create_table :user_badges do |t|
      t.references :user
      t.references :badge
      t.references :post
      t.timestamps
    end
    add_index(:user_badges, :user_id)
    add_index(:user_badges, :badge_id)
    add_index(:user_badges, :post_id)
  end
end
