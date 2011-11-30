class AddSavingsRateToQuarter < ActiveRecord::Migration
  def change
    add_column :quarters, :personal_savings_rate, :integer
  end
end
