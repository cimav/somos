class CreateSidebarItems < ActiveRecord::Migration
  def change
    create_table :sidebar_items do |t|
      t.string     :name
      t.string     :url
      t.integer    :position
      t.integer    :sidebar_type, :default => 1
      t.integer    :status,   :null => false, :default => 1
      t.timestamps
    end
  end
end
