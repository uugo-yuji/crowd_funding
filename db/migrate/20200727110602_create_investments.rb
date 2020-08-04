class CreateInvestments < ActiveRecord::Migration[6.0]
  def change
    create_table :investments do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.string :price

      t.timestamps
    end
  end
end
