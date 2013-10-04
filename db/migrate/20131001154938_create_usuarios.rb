class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.string :email
      t.string :password
      t.boolean :admin 
      
      t.timestamps
    end
  end
end
