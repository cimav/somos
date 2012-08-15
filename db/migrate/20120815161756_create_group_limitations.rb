class CreateGroupLimitations < ActiveRecord::Migration
  def change
    create_table :group_limitations do |t|
      t.references :group
      t.integer :by_group_id
      t.timestamps
    end
    add_index(:group_limitations, :group_id)
    add_index(:group_limitations, :by_group_id)
  end
end
