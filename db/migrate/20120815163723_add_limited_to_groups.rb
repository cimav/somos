class AddLimitedToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :limited, :string
  end
end
