class CreatePageFileSections < ActiveRecord::Migration
  def change
    create_table :page_file_sections do |t|
      t.references :page
      t.string     :title
      t.text       :description
      t.integer    :position
      t.timestamps
    end
    add_index('page_file_sections', 'page_id')
  end
end
