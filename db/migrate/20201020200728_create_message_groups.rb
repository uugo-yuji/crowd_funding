class CreateMessageGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :message_groups do |t|
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
