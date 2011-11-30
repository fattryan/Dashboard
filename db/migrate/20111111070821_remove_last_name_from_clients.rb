class RemoveLastNameFromClients < ActiveRecord::Migration
  def up
    remove_column :clients, :last_name
  end

  def down
  end
end
