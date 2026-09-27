class CreateProductImages < ActiveRecord::Migration[8.1]
  def change
    create_table :product_images do |t|
      t.string :image_url
      t.string :public_id
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
