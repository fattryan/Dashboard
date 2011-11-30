class RenameTotal < ActiveRecord::Migration
  def up
    rename_column :quarters, :total, :total_savings
  end

  def down
  end
end
