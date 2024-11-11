# views/api/v1/recipes/show.json.jbuilder
json.recipe do
  json.id          @recipe.id
  json.name        @recipe.name
  json.description @recipe.description
  json.ingredients @recipe.ingredients
  json.user_id     @recipe.user_id
  json.created_at  @recipe.created_at
  json.updated_at  @recipe.updated_at
end