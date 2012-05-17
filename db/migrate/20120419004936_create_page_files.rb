class CreatePageFiles < ActiveRecord::Migration
  def change
    create_table :page_files do |t|
      t.references :page_file_section
      t.string     :file
      t.string     :title
      t.text       :description
      t.integer    :position
      t.timestamps
    end
    add_index('page_files', 'page_file_section_id')
  end
end
