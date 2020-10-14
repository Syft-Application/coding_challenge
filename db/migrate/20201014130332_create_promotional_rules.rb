class CreatePromotionalRules < ActiveRecord::Migration[6.0]
  def change
    create_table :promotional_rules do |t|
      t.references :product, optional: true
      t.string :discount_type
      t.float :discount_amount
      t.integer :product_amount
      t.integer :price_amount
      t.timestamps
    end
  end
end
