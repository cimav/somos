class AddLimitedToSidebarItems < ActiveRecord::Migration
  def change
    add_column :sidebar_items, :limited, :string
  end
end
