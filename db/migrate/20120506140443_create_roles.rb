class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
    add_index :roles, :parent_id
  end
end
