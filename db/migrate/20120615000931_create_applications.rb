class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string     :short_name, :limit => 20
      t.string     :name
      t.string     :icon
      t.string     :url
      t.integer    :app_type, :default => 1
      t.integer    :status,   :null => false, :default => 1
      t.timestamps
    end
  end
end
