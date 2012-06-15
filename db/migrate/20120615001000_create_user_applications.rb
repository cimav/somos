class CreateUserApplications < ActiveRecord::Migration
  def change
    create_table :user_applications do |t|
      t.references :user
      t.references :application
      t.timestamps
    end
    add_index(:user_applications, :user_id)
    add_index(:user_applications, :application_id)
  end

end
