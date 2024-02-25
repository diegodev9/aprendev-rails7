class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end

    add_index :favorites, [:user_id, :product_id], unique: true #para que el usuario no le guste varias veces un articulo
  end
end
