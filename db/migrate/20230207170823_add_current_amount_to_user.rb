class AddCurrentAmountToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :current_amount, :decimal, defaul: 0.0
  end
end
