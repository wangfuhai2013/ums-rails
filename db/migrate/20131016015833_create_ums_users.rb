class CreateUmsUsers < ActiveRecord::Migration
  def change
    create_table :ums_users do |t|
      t.string :account
      t.string :name
      t.string :email
      t.string :hashed_password
      t.string :salt
      t.datetime :last_login_time
      t.string :last_login_ip
      t.integer :login_count
      t.references :role, index: true
      t.boolean :is_enabled

      t.timestamps
    end
  end
end
