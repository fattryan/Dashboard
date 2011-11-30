class CreateQuarters < ActiveRecord::Migration
  def change
    create_table :quarters do |t|
      t.integer :client_id
      t.integer :quarter
      t.integer :year
      t.integer :production
      t.integer :collections
      t.integer :total_visits
      t.integer :new_patients
      t.integer :net_worth
      t.integer :income
      t.integer :qualified_savings
      t.integer :taxable_savings

      t.timestamps
    end
  end
end
