class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     :username,    :null => false
      t.string     :first_name,  :null => false
      t.string     :last_name,   :null => false
      t.string     :display_name,:null => false
      t.string     :occupation
      t.string     :email,       :null => false
      t.string     :location
      t.integer    :reports_to
      t.text       :bio
      t.date       :birth_date
      t.date       :start_date
      t.date       :end_date
      t.string     :address1
      t.string     :address2
      t.string     :city
      t.references :state
      t.string     :zip,          :limit => 20
      t.references :country
      t.string     :mobile_phone, :limit => 20
      t.string     :home_phone,   :limit => 20
      t.string     :work_phone,   :limit => 20
      t.string     :website
      t.string     :lat,          :limit => 20
      t.string     :long,         :limit => 20
      t.string     :image
      t.string     :token
      t.integer    :status,     :null => false, :default => 1
      t.timestamps
    end
    add_index(:users, :username)
    add_index(:users, :email)
    add_index(:users, :country_id)
    add_index(:users, :state_id)
  end
end
