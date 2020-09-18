class AddGoalPriceToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :goal_price, :string
  end
end
