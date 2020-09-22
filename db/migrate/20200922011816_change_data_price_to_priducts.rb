class ChangeDataPriceToPriducts < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :goal_price, :integer
  end
end
