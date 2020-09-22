class ChangeDataPriceToInvestments < ActiveRecord::Migration[6.0]
  def change
    change_column :investments, :price, :integer
  end
end
