class AddContentToSidebarItems < ActiveRecord::Migration
  def change
    add_column :sidebar_items, :content, :text
  end
end
