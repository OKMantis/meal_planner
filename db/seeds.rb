puts "Seeding..."

dietary_tags = ["vegan", "vegetarian", "gluten-free", "dairy-free", "nut-free"]
cuisine_tags = ["italian", "mexican", "japanese", "indian", "thai"]
course_tags  = ["breakfast", "lunch", "dinner", "snack", "dessert"]
all_tag_names = dietary_tags + cuisine_tags + course_tags

tags = all_tag_names.map do |name|
  category = dietary_tags.include?(name) ? "dietary" :
             cuisine_tags.include?(name)  ? "cuisine"  : "course"
  Tag.find_or_create_by!(name: name, category: category)
end

ingredients_list = [
  "flour", "sugar", "butter", "eggs", "milk", "salt",
  "olive oil", "garlic", "onion", "tomato", "chicken breast",
  "pasta", "rice", "lemon", "parsley", "cumin",
  "ginger", "soy sauce", "coconut milk", "black pepper"
]
ingredients = ingredients_list.map { |n| Ingredient.find_or_create_by!(name: n, unit: "g") }

roles = ["member", "member", "member", "admin"]
users = 50.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    name:  Faker::Name.name,
    role:  roles.sample
  )
end
puts "Created #{users.count} users"

recipes = 200.times.map do
  Recipe.create!(
    title:              Faker::Food.dish,
    description:        Faker::Lorem.paragraph(sentence_count: 3),
    cook_time_minutes:  [15, 20, 30, 45, 60, 90].sample,
    servings:           [2, 4, 6, 8].sample,
    published:          [true, true, true, false].sample,
    user:               users.sample
  )
end
puts "Created #{recipes.count} recipes"

recipes.each do |recipe|
  ingredients.sample(rand(3..7)).each do |ing|
    RecipeIngredient.find_or_create_by!(recipe: recipe, ingredient: ing) do |ri|
      ri.quantity = rand(50..500)
    end
  end
  tags.sample(rand(2..5)).each do |tag|
    RecipeTag.find_or_create_by!(recipe: recipe, tag: tag)
  end
end

users.each do |user|
  meal_plan = MealPlan.create!(user: user, planned_for: Date.today + rand(0..14))
  recipes.sample(rand(5..14)).each do |recipe|
    MealPlanEntry.create!(
      meal_plan:  meal_plan,
      recipe:     recipe,
      meal_slot: ["breakfast", "lunch", "dinner", "snack"].sample
    )
  end
end

puts "Done. Seed complete."