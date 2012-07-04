class AddHeightToSidebarItems < ActiveRecord::Migration
  def change
    add_column :sidebar_items, :height, :string
  end
end
