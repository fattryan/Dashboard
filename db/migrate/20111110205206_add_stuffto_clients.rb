class AddStufftoClients < ActiveRecord::Migration
  def up
    add_column :clients, :date_started, :date
    add_column :clients, :business_name, :string
  end

  def down
    remove_column :clients, :date_started
    remove_column :clients, :business_name
  end
end
