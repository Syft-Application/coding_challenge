class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :product_code, index: true
      t.string :name
      t.float :price
      t.timestamps
    end
  end
end
