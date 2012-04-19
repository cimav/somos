class CreatePageFiles < ActiveRecord::Migration
  def change
    create_table :page_files do |t|
      t.references :page
      t.string     :file
      t.timestamps
    end
    add_index('page_files', 'page_id')
  end
end
