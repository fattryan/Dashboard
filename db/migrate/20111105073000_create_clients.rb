class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.date :birthday
      t.string :specialty
      t.string :email

      t.timestamps
    end
  end
end
