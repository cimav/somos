class AddDefaultPageToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :default_page, :integer
  end
end
