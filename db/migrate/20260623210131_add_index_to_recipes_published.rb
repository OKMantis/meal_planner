class AddIndexToRecipesPublished < ActiveRecord::Migration[8.1]
  def change
    add_index :recipes, :published
  end
end
