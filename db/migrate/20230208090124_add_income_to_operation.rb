class AddIncomeToOperation < ActiveRecord::Migration[7.0]
  def change
    add_column :operations, :income, :boolean
  end
end
