module API
    module V1
      class RecipesController < API::V1::APIController
        before_action :authenticate_user!
        before_action :set_recipe, only: %i[show update destroy]
        def index
          @recipes = current_user.recipes
          @pagy, @records = pagy(@recipes)
        end
  
        def show
          @recipes = Recipe.find(params[:id])
        end
  
        def create
          @recipe = current_user.recipes.build(recipe_params)
          @recipe.save!
        end
  
        def destroy
          @recipe = Recipe.find(params[:id])
          @recipe.destroy!
        end
  
        private
  
        def recipe_params
          params.require(:recipe).permit(:name, :description, :ingredients)
        end

        def set_recipe
          @recipe = current_user.recipes.find(params[:id])
        end
      end
    end
  end
  