class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :category_type, null: false
      t.integer :model, null: false
      t.timestamps
    end
  end
end
