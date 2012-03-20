class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.string :code
      t.string :lat,  :limit => 20
      t.string :long, :limit => 20
      t.timestamps
    end
  end
end
