class AddStatusToPageFileSections < ActiveRecord::Migration
  def change
    add_column :page_file_sections, :status, :integer
  end
end
