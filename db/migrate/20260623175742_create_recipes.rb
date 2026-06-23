class CreateRecipes < ActiveRecord::Migration[8.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.integer :cook_time_minutes
      t.integer :servings
      t.boolean :published
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
