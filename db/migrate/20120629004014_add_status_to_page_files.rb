class AddStatusToPageFiles < ActiveRecord::Migration
  def change
    add_column :page_files, :status, :integer
  end
end
