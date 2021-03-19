class AddStatusDefalutToProducts < ActiveRecord::Migration[6.0]
  def up
    add_column :products, :status, :integer, default: 0
  end

  def down
    remove_column :products, :status, :integer, defalut: 0
  end
end
