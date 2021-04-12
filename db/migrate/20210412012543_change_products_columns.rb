class ChangeProductsColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :status, :integer, default: 0 
  end
end
