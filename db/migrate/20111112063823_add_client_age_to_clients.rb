class AddClientAgeToClients < ActiveRecord::Migration
  def change
    add_column :clients, :client_age, :integer
  end
end
