# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show destroy]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    # Usamos el servicio para generar la receta
    preferences = current_user.preferences.map { |preference| "#{preference.name}: #{preference.description}" }
    service = RecipeGeneratorService.new(recipe_params[:ingredients], current_user.id, preferences)
    
    begin
      generated_recipe = service.call
      @recipe = current_user.recipes.build(
        name: generated_recipe["name"],
        description: generated_recipe["content"],
        ingredients: recipe_params[:ingredients]
      )

      if @recipe.save
        redirect_to recipes_path, notice: 'Recipe was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end

    rescue RecipeGeneratorServiceError => e
      # Captura cualquier error del servicio y muestra un mensaje de error
      flash.now[:alert] = "Failed to create recipe: #{e.message}"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @recipe.destroy
      redirect_to recipes_path, notice: t('views.recipes.destroy_success')
    else
      redirect_to recipes_path, alert: t('views.recipes.destroy_failure')
    end
  end

  private

    def set_recipe
      @recipe = current_user.recipes.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:name, :description, :ingredients)
    end
end
