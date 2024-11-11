# frozen_string_literal: true

# app/views/api/v1/recipes/create.json.jbuilder
# views/api/v1/recipes/create.json.jbuilder
json.extract! @recipe, :id, :name, :description, :ingredients, :user_id, :created_at, :updated_at

