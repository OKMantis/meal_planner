class CreateMealPlans < ActiveRecord::Migration[8.1]
  def change
    create_table :meal_plans do |t|
      t.references :user, null: false, foreign_key: true
      t.date :planned_for

      t.timestamps
    end
  end
end
