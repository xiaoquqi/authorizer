class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :fname
      t.string :lname
      t.string :crypted_password, :limit => 40
      t.string :salt, :limit => 40
      t.boolean :remember_token
      t.date :remember_token_expires_at

      t.timestamps
    end
  end
end
