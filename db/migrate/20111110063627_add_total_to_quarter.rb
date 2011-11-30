class AddTotalToQuarter < ActiveRecord::Migration
  def change
    add_column :quarters, :total, :integer
  end
end
