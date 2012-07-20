class AddPhoneTypesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone1_desc, :string
    rename_column :users, :work_phone, :phone1
    add_column :users, :phone2_desc, :string
    rename_column :users, :mobile_phone, :phone2
    add_column :users, :phone3_desc, :string
    rename_column :users, :home_phone, :phone3
  end
end
